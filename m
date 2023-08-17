Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399577F567
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350364AbjHQLiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350318AbjHQLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:37:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD6F7;
        Thu, 17 Aug 2023 04:37:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-407ff54164dso46076651cf.2;
        Thu, 17 Aug 2023 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692272274; x=1692877074;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w31IQ5YkuY2ltFjG4ujyeSdaSaelLhYfdYtgX94Kf4E=;
        b=EHVGSdB8PoUrtTCoQFXL+MK+2xc+VAtPK4qKUYQwyzjM5DBPYrCKcPmzfgsVCpr4Cw
         Ebfe/1EtiuLdE0T/m99L0FuBCVRELNfBzDg+8n9tvhQCFZcqXLXhLlRZADiUn2n7I9wi
         WcyDAEnxKkc9AZGWAbHlBZhXrJlees9LEUFrOcTDcnWMHX8haQk3ATXoTp1E8lyFoyUd
         qwCEQreDh3Zyda1l8U2rFHCgUKoqVICpGSmUM+324uwRYvlnh+aZh8YKDdQb44WVTcle
         DDjNZQUIPKuVWpEK1CsvwtxQnouYWI485BC9zeteA/+abMq9yb1K/HOKACy1ztRQVn/+
         ilSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272274; x=1692877074;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w31IQ5YkuY2ltFjG4ujyeSdaSaelLhYfdYtgX94Kf4E=;
        b=apOmzX/6xhlQoDyfJo97K0Ad6gr8xVvCDvg0lrWkUXqEx7ARgRwDBQYuNUFt4o5MnF
         kWN7MwO2Ho4fkGaKlcHViJ00TTkKlwln7RSB2rMh5mMrJZi5AdsrsjKZpnEz13ZLr/+M
         R6oGwG7uIghxQ9gZT8I2qtw8U1wroaDC2TzOXFvU16FSF+ZyZrM41PoHQgBcKcm4x+pS
         ULOjSu632JezC7Vs6U6IfBdKr8GKtwR9mOy7MBW2YF8Dkc6kvDaMyNk2AbLLlVzg0YpB
         eHnO9MGx/d/RaI6DNFzPoLQEXRU2WsC0Ezd+G07UsjjNaE7xa+V92uA5CzHx5OekQK5p
         ggBg==
X-Gm-Message-State: AOJu0YxG2of90y8k9CPt2EXknALsXwgvHVRZZEOFTVVy97YT+celKb+I
        SjrqB3iBMWFt0MqasI32+yc=
X-Google-Smtp-Source: AGHT+IFI3+CHPpKULX2tpEaGS8l+bPl1rOS8rSkMfyrr656mErrSbDd1H1POnL349Ph/iwf4YakojA==
X-Received: by 2002:a05:622a:182:b0:40e:6f1:3d38 with SMTP id s2-20020a05622a018200b0040e06f13d38mr6443538qtw.8.1692272274313;
        Thu, 17 Aug 2023 04:37:54 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05622a229800b00403cc36f318sm5161369qtb.6.2023.08.17.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:37:53 -0700 (PDT)
Date:   Thu, 17 Aug 2023 07:37:51 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] arch/mips/configs/*_defconfig cleanup
Message-ID: <20230817113751.GA25020@localhost>
References: <20230817025942.3209-1-twoerner@gmail.com>
 <20230817025942.3209-4-twoerner@gmail.com>
 <f7230276-decf-2248-52b2-c2de4a13647c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7230276-decf-2248-52b2-c2de4a13647c@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-08-17 @ 09:33:13 AM, Philippe Mathieu-Daudé wrote:
> Hi Trevor,
> 
> On 17/8/23 04:59, Trevor Woerner wrote:
> > Drop CONFIG_IP_NF_TARGET_CLUSTERIP from any remaining mips defconfigs as it
> > was removed in commit 57f8e00d8a82 ("usb: 71 musb: Drop old unused am35x
> > glue layer").
> 
> How 57f8e00d8a82 is related? Do you mean commit 9db5d918e2c0
> ("netfilter: ip_tables: remove clusterip target")?

Yes thank you. I'll send a v3.

> 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   arch/mips/configs/ip22_defconfig        | 1 -
> >   arch/mips/configs/malta_defconfig       | 1 -
> >   arch/mips/configs/malta_kvm_defconfig   | 1 -
> >   arch/mips/configs/maltaup_xpa_defconfig | 1 -
> >   arch/mips/configs/rm200_defconfig       | 1 -
> >   5 files changed, 5 deletions(-)
> > 
> > diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> > index 44821f497261..dc49b09d492b 100644
> > --- a/arch/mips/configs/ip22_defconfig
> > +++ b/arch/mips/configs/ip22_defconfig
> > @@ -127,7 +127,6 @@ CONFIG_IP_NF_MATCH_TTL=m
> >   CONFIG_IP_NF_FILTER=m
> >   CONFIG_IP_NF_TARGET_REJECT=m
> >   CONFIG_IP_NF_MANGLE=m
> > -CONFIG_IP_NF_TARGET_CLUSTERIP=m
> >   CONFIG_IP_NF_TARGET_ECN=m
> >   CONFIG_IP_NF_TARGET_TTL=m
> >   CONFIG_IP_NF_RAW=m
> 
