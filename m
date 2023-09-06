Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12080794387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbjIFTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbjIFTD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:03:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6A1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:03:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1d4e0c29028so111531fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026991; x=1694631791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3q/T6tNlmeW82eZnvMrVcLhUOOtgnqhDwVveJXqFWk=;
        b=G1aCnVUUrRo++zuPncVLSOZduaH1IiOg19S03kQk70Mi/TdKNpamy2NbOboHdLNOgS
         INIlGbbBbB5laScsPdsk7zwbG52xPAXscKpwN7rExYe7mpECLo/iGK+FhBtAC8jRyR2/
         rKaKTLPFkW9CuJ1gseoPXpPf2kOCmnnpAZxjB6iE7W6/3a2BwLlceyqQ7PzZ0f+yYKYf
         +yVLMqqyb+AJMMR0ItK2PVoCJLXkW1MWOHX63uU40gMKwy801qiJdsDpfP9fDerponp9
         NWHKdyn+JAD6vmW9ftTdYxbq8i6Nq/RKqlhwwtdmWlCj542CBgMcJ7XigtufWHhUk55J
         t4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026991; x=1694631791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3q/T6tNlmeW82eZnvMrVcLhUOOtgnqhDwVveJXqFWk=;
        b=PNSv32togUagJDxI3+Ud1URcs6J4aKOGlWKpV/UK943DpgKi4ttFgljwhyLX6SJJj6
         BYYjkOqUd0GEbWXGkav2yAqVZLxI0QEUEnfXJAJhcRn0mS+i6vywDj1wQ5pz47/TAVdX
         C/YRlsfh0Go9drVS7JiJmQfeh+Qhu1NwYcOFdcGl+wrwZZoh3R02cV0Cf6P0euGn1J2C
         m5+OCq/mvaPXjtn/owBbGKlWPJtffSMRB8/AktaZteROYcrF2y0pI+2Cg7GNJaopLoYb
         GflALrpPZ2Cad72pHGHEo+nfQz5rkZ6izeDf9hEuT1eXVv6qM0ZvO6wkb6Tho2qKDvQ9
         gK/A==
X-Gm-Message-State: AOJu0Yx2huKpm9Me0+Mi73eHS072sHKMiJ9eCVkYuG5BDUnKHrrAaWJM
        iJBpSMp0GoGd1qiwk8Wobzw=
X-Google-Smtp-Source: AGHT+IFiZtabVhUuY1bomsXQZWF6oaToQkCFgYCHPt/3Khyme6ZSuBPbGJFAJ0jyeRFKC3p9n0wiWw==
X-Received: by 2002:a05:6870:5b81:b0:1bf:440:a055 with SMTP id em1-20020a0568705b8100b001bf0440a055mr18592017oab.4.1694026991204;
        Wed, 06 Sep 2023 12:03:11 -0700 (PDT)
Received: from geday ([2804:7f2:8006:99ef:50e4:98e3:42a7:1619])
        by smtp.gmail.com with ESMTPSA id tp10-20020a0568718b8a00b0019e6b96f909sm7918494oab.22.2023.09.06.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:03:10 -0700 (PDT)
Date:   Wed, 6 Sep 2023 16:03:10 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Antonio Terceiro <antonio.terceiro@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Message-ID: <ZPjM7op/B/CGCF/N@geday>
References: <ZPelHaX/Lt++kkOm@linaro.org>
 <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
 <ZPjGuCdmPgqznc5t@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjGuCdmPgqznc5t@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:36:40PM -0300, Antonio Terceiro wrote:
> On Wed, Sep 06, 2023 at 01:49:16PM +0100, Robin Murphy wrote:
> > On 2023-09-06 07:10, Takashi Iwai wrote:
> > > On Wed, 06 Sep 2023 00:01:01 +0200,
> > > Antonio Terceiro wrote:
> > > > 
> > > > Hi,
> > > > 

Hi Antonio, my 2 cents:

> > > > I'm using an arm64 workstation, and wanted to add a sound card to it. I bought
> > > > one who was pretty popular around where I live, and it is supported by the
> > > > snd-cmipci driver.

Specifically, which arm64 workstation? I'm guessing Compute Module 4 IO
Board + Raspbery Pi CM4? This detail is important because the stack
trace you provided only references generic PCI calls and there's a need
to know exactly which PCIe driver could be failing. Is it pcie-brcmstb?

Thanks,
Geraldo Nascimento

