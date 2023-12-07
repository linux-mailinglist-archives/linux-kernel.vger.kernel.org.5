Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC95808A80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjLGO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjLGO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:27:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CAD53
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:27:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2868cf6cb82so816300a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701959248; x=1702564048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnUqi8dAEgGMyEzBxdD28hEtaCGQO1gXXHV0T1kN7CU=;
        b=S/HaNrIlZ1DvlTNB0E5lv/B/jagUzSzYVkBFDPkoNIN1LiRa1I0xHQINUKVCg0TNSR
         SM8n1x6D6WJHzB+l3IkgyqBLYA5Jz9TniilXPvrPTiF/RF22DXM2XhS7PgktPvNbpLWh
         eQy/d/QFNFVcy+m/YZA/NdrB5w7zq9ehc4c6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959248; x=1702564048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnUqi8dAEgGMyEzBxdD28hEtaCGQO1gXXHV0T1kN7CU=;
        b=bGqD6K0GmrLb5UWrTLDw2OlDTM1dqZobdcnc9xKN8ez4NcBIt5qAbmer0KWtl00Cia
         mqFYvZxLmE0IimWi2aJ5v9YYwUgsIwxySNa7sNCtB81oCprWqgawf2nx3236FFxTj99z
         dFMBDbQ7QJqr815pOjcDV48nN47m/iqWySTGsmbIruqNi3ojfQOtmFjpSOE+2OR+khKm
         c7O2KOnRbfSALDspI1xgnajQCBWgIMo4p4pleWBAPVxJ3uPxHoWkZHDLmy+FKd9d33fd
         B+Fohf0wI0Ups4bzoZ7v7JMWKfezigdE40kzeOII3pkCuyOfFzmBqfls6AVnP2FLmb/X
         jDHA==
X-Gm-Message-State: AOJu0Yy5Cw4hK8C7EKV5DCkXAlcWz9BEwNc9tO5IYpKkahtzl6kqsqsD
        SditE2VfmxTLEDPjTNx3glpfXA==
X-Google-Smtp-Source: AGHT+IH8AzbuT3bEW5QtQ3VpbuixskHTKbrXXL1zs3HHhHdzRy4lAaYreOoFMvEXA8A9ADp82mykHw==
X-Received: by 2002:a17:90a:e009:b0:286:6cc0:b918 with SMTP id u9-20020a17090ae00900b002866cc0b918mr2087016pjy.79.1701959247711;
        Thu, 07 Dec 2023 06:27:27 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:e0f4:e383:e626:f567])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902654f00b001cfc2d024edsm1507200pln.29.2023.12.07.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:27:27 -0800 (PST)
Date:   Thu, 7 Dec 2023 22:27:23 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231207142723.GA3187877@google.com>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203153401.GV8402@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> > 
> > The files compress from about 86MB to 24MB using this approach.
> > 
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> > 
> > Add a 'make image.fit' build target for arm64, as well. Use
> > FIT_COMPRESSION to select a different algorithm.
> > 
> > The FIT can be examined using 'dumpimage -l'.
> > 
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> > 
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
> 
> FIT images are very useful, so I think this is a very welcome addition
> to the kernel build system. It can get tricky though: given the
> versatile nature of FIT images, there can't be any
> one-size-fits-them-all solution to build them, and striking the right
> balance between what makes sense for the kernel and the features that
> users may request will probably lead to bikeshedding. As we all love
> bikeshedding, I thought I would start selfishly, with a personal use
> case :-) This isn't a yak-shaving request though, I don't see any reason
> to delay merging this series.
> 
> Have you envisioned building FIT images with a subset of DTBs, or adding
> DTBOs ? Both would be fairly trivial extensions to this script by
> extending the supported command line arguments. It would perhaps be more
> difficult to integrate in the kernel build system though. This leads me
> to a second question: would you consider merging extensions to this
> script if they are not used by the kernel build system, but meant for
> users who manually invoke the script ? More generally, is the script

We'd also be interested in some customization, though in a different way.
We imagine having a rule file that says X compatible string should map
to A base DTB, plus B and C DTBO for the configuration section. The base
DTB would carry all common elements of some device, while the DTBOs
carry all the possible second source components, like different display
panels or MIPI cameras for instance. This could drastically reduce the
size of FIT images in ChromeOS by deduplicating all the common stuff.

> meant to be used stand-alone as well, in which case its command line
> arguments need to remain backward-compatible, or do you see it as being
> internal to the kernel ?

[...]

ChenYu
