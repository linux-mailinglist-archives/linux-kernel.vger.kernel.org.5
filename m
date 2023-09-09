Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24E79973B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbjIIKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjIIKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:01:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC49D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 03:01:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so46294291fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694253678; x=1694858478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oP3Ad7tpf4jZq5Asm4UcDHA1fh15q5/8MbXPXoqPnzE=;
        b=ojiMcqHjf0+aQ6Dv5wR82y9xVaB5zfbR3G3jdtgtPAX6fuV+bRjkHdT51qtbIy0Spi
         1dRV170UyasGIJig/gPQZ1Xg2iRQDCzrCwAEHVM5UF2LNgHO8+sftTgYJGDZkAq1R4qZ
         aeh1rROTn49pYPiJqcdwNhDgSB7L0QWTgGCSvY4LxLLD53t0nhzdKH6fVVEu2e5trF2y
         wfrHMvQv6x2/iJZydRhJohrFi/EI3mQ4xvWq+o1reZeLkJckacLkn6AbLJvIWReJ24Az
         DbhFdtH5tlcWG7W5ghY7XGPDI/Y93Pwo4uGJC6/kMRCaZl12dZQ6JDechekOCxeleKi0
         VpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694253678; x=1694858478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP3Ad7tpf4jZq5Asm4UcDHA1fh15q5/8MbXPXoqPnzE=;
        b=FLc+kh1Ep1MJDwSXkw8sGKHVHG+560k9aeKPldA+p6sRvo8PRSh3u1ii4Dq/p7ylVf
         wCdtzCoIMqIm3jWoE+s0IOdZ4UuxgbE43mapQYbmPlCwkjARQJBg05fzhgSGoRm/z9t3
         rd/f2eTjxVMXUQyHOeL473rlp/JCzOpSZPEJGX7jRwkxOnP9SxhvbQtw49JbfPO7jL+w
         8Ek7IEQ+d1WLbrgDM9dWTr7Wluitm2FVOrOKEQSa9kvr6KUIhbbiLCVf71Yx8Lbi5aaM
         XgmcUBADD64Xfq4mHMD9ZPx33n40wiFExjjgHA56/NZ0J5T2H9OAEniEJs4gia1WsiJA
         esmg==
X-Gm-Message-State: AOJu0Yx7sOpvhuNBdtv2OF/VjZuGdtz3727dO9/ROR7vPAB0meFWoQDi
        OjXtWew4jVZ5IWt6QTKb/jCrUBY5/NI=
X-Google-Smtp-Source: AGHT+IG+ak0urT0LkXjEl/AFuu5XF+f2hYsvtZqQOgwc/PJ9LemWW+ubSRznDLamHiePAqay7dS0nw==
X-Received: by 2002:a2e:9b4c:0:b0:2b6:a5df:c7fb with SMTP id o12-20020a2e9b4c000000b002b6a5dfc7fbmr3881018ljj.26.1694253677892;
        Sat, 09 Sep 2023 03:01:17 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id gf13-20020a170906e20d00b009928b4e3b9fsm2161642ejb.114.2023.09.09.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 03:01:17 -0700 (PDT)
Date:   Sat, 9 Sep 2023 12:01:15 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <ZPxCa/UOd7T2phqX@nam-dell>
References: <ZPnLw+njcL/D391S@ubuntu.myguest.virtualbox.org>
 <2023090724-trial-ipod-93d2@gregkh>
 <ZPwwHY1TDOBEljxr@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPwwHY1TDOBEljxr@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 02:13:09PM +0530, Pavan Bobba wrote:
> On Thu, Sep 07, 2023 at 03:43:53PM +0100, Greg KH wrote:
> > On Thu, Sep 07, 2023 at 06:40:27PM +0530, Pavan Bobba wrote:
> > > Below array names updated as per coding guidelines:
> > > 
> > >    1.byVT3253B0_AGC4_RFMD2959
> > >    2.byVT3253B0_AIROHA2230
> > >    3.byVT3253B0_UW2451
> > >    4.byVT3253B0_AGC
> > > 
> > >    Conversions performed:
> > >    a.type encoding info dropped from names
> > >    b.names replaced by snakecase
> > > 
> > >    Issue found by checkpatch
> > > 
> > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > ---
> > >  v1 -> v2: Name of the tool added in the body of explanation,
> > >            which found this issue
> > > 
> > >  v2 -> v3: subject modified to more specific detail
> > 
> > Any specific reason you are not sending this to the maintainer that can
> > take it?
> i used scripts/get_maintainer.pl to get maintainers names and i am
> adding all those people to the mail. kindly let me know the maintainer id
> and the correct way to know the mainter of a file

    ./scripts/get_maintainer.pl ~/Downloads/PATCH-v3-staging-vt6655-Type-encoding-info-dropped-from-array-name-byVT3253B0_.txt
Forest Bond <forest@alittletooquiet.net> (odd fixer:STAGING - VIA VT665X DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:2/2=100%)
Michael Straube <straube.linux@gmail.com> (commit_signer:2/2=100%,authored:2/2=100%,removed_lines:44/44=100%)
linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Greg shows up as one of the maintainers for me.

Either a bug with get_maintainer.pl (unlikely), or you did something incorrectly.

Best regards,
Nam
