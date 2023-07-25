Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB87603B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGYAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGYAOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:14:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5B1736;
        Mon, 24 Jul 2023 17:14:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b4748fe4so27913665ad.1;
        Mon, 24 Jul 2023 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690244078; x=1690848878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CckHXTR2oTwWrbjeu6pJlCDtPBaFMqvBE18C7STfqU=;
        b=lN1xNoTZXCMBpicnSJL5Un1oNhkTziTlyyH5n9SFM3rVpf4GJ7XA0CSjoS7+HbhobB
         AO8QYTSwP7y55NP/nzetAhkD1nqdJDzvViTSfi0Rg3FCncnadyKjt4Ou2F3Dmqk6Px3K
         DQvI8r7HT/fUqqCD1mycqIn0cuyF2Pdnm93tjEDt3QGHoGp2/TyypBpX8hbsi9lhn9d8
         FrQmk6aZJuJLZy/7UARSxXSUfFtJnR053VZQfYfNCaKI7F9gJ4FovKHuy8e8RDVk+qo6
         kCp37A5seS9r1wa+J5nd/u4M2gz0ntcDSzDY9OavYEpQ+IYF3IV0e6mhCAFnrRyVs7nu
         l8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690244078; x=1690848878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CckHXTR2oTwWrbjeu6pJlCDtPBaFMqvBE18C7STfqU=;
        b=J8UgpRkQiIrLFrHvWQp3QY5sSf1zBRDSd3UgPkc8nxYcRM1oIQhPtcF+WfsVESMoX6
         xsf4nxLz/bSnLfzK/w97KCZhAzGPRKpuLykbIiLiJy8eBEM50YP1ZQJ8elGPRR0J+doL
         CdnWKdBAxokZrpOgtXyT1hVV+JozSnIx2ZYS1PGSa0wp9Bjtn3luINY7V9XnsW4yKbqg
         hGW7QtXUFyQ67+CjtHppL850biscS2kiaBITMxel6sZEux+k3wrKkio+W+ef+yN0ZLXE
         2yjtbld/i3X/3pIloWbwqZMBTttOQSLOMOYDTovrrbzRByPUrgX9IB9SDFfYtODqgyq5
         +8Dw==
X-Gm-Message-State: ABy/qLYic25rawJf0ZenWzvE9Srez5B6k4wTgAHlt0qiRgNrlwiirVot
        SavYXTwtQmgUbyZk4XSJgy8=
X-Google-Smtp-Source: APBJJlHWAw1bYCjH+wGqKMn15WdxUnuXM/WDoBGN0PpuHzpmKiJBF3pNopEgRUoH4e+a39kvGPq7fw==
X-Received: by 2002:a17:902:db0f:b0:1bb:b2f7:e058 with SMTP id m15-20020a170902db0f00b001bbb2f7e058mr2253939plx.52.1690244077769;
        Mon, 24 Jul 2023 17:14:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9d8f:da31:e274:eeb5])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001bb8be10a84sm5135174plc.304.2023.07.24.17.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:14:37 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:14:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Verot <verot.wrongdoer713@simplelogin.com>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.4.4 breaks Elan Touchpad 1206
Message-ID: <ZL8T6ptGgYdF3D96@google.com>
References: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
 <ZL8S2/Ujprk4KgzT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL8S2/Ujprk4KgzT@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:10:03PM -0700, Dmitry Torokhov wrote:
> On Tue, Jul 25, 2023 at 07:00:21AM +0700, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> > > Description:
> > > When booting into Linux 6.4.4, system no longer recognizes touchpad input (confirmed with xinput). On the lts release, 6.1.39, the input is still recognized.
> > > 
> > > Additional info:
> > > * package version(s): Linux 6.4.4, 6.1.39
> > > * Device: ELAN1206:00 04F3:30F1 Touchpad
> > > 
> > > Steps to reproduce:
> > > - Install 6.4.4 with Elan Touchpad 1206
> > > - Reboot
> > > 
> > > The issue might be related to bisected commit id: 7b63a88bb62ba2ddf5fcd956be85fe46624628b9
> > > This is the only recent commit related to Elantech drivers I've noticed that may have broken the input.
> > 
> > See Bugzilla for the full thread:
> > 
> > To the reporter (Verot): Can you attach dmesg and lspci output?
> > 
> > Anyway, I'm adding this regression to be tracked by regzbot:
> > 
> > #regzbot introduced: 7b63a88bb62ba2 https://bugzilla.kernel.org/show_bug.cgi?id=217701
> > #regzbot title: OOB protocol access fix breaks Elan Touchpad 1206
> 
> Please don't as ELAN1206:00 04F3:30F1 looks like I2C-HID and not PS/2
> device that 7b63a88bb62ba2 would affect.

Also 7b63a88bb62ba2 is present in 6.1 since v6.1.34.

Thanks.

-- 
Dmitry
