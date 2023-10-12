Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8E7C79FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443046AbjJLWxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442450AbjJLWxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:53:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F7A9;
        Thu, 12 Oct 2023 15:53:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690d2441b95so1116408b3a.1;
        Thu, 12 Oct 2023 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697151188; x=1697755988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78dLfHiKtRMa9+mkxUCYKM56t0Kv23O6vbCoyWzPuyY=;
        b=GwuDzZKW9OKn4fFk72XE3GOsg5imotFXb3+DINzqcMfIh7MHSvd6PbmQrlrO75kHfb
         EU/d9wIgWXd1NPwk0+Jtzza+pTN+A2YOiFtMAuJGtZKJTB9dDCiF/OISD633Anhfd71x
         l9QdNIRREbBXcskLxpN7whf0uN9sDxA2ovNNaLn3uevTpwLldB4grRXJtQU6/n/Xdy/J
         xuB+GrbYgT06AFJxz4giLR9jc+onq7VogitRmv/CQvDIaYOjx/Bu9Aik/oHMixEbnnk7
         74qv0B4wUH14I8rPQCvFIwP3Pu9l/dcg3hSfMCFEN55dyXmGkSdzM4Yhjv5QeqLCF204
         kmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151188; x=1697755988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78dLfHiKtRMa9+mkxUCYKM56t0Kv23O6vbCoyWzPuyY=;
        b=JoivqA7ex7VwARj1T5gzy9yBYij+cnkLDTwEeNOsG6WBZBtj1tTSmpdUexlgwkQimX
         2G4jkbxR/42tdqRd/iJOqpmzlMNdla9tnZsl5KoEu5zUi+DRpRhUXduVVVRAb4RiKKeq
         lHvZQ+R/8FGQ6UZ98C0n830wV4ofUHvQaf1qL498h5jyYlkTnZC2EufNkSxLj9GTVYr6
         BM3Rir2TEKHdig8G3+f8MlltlZ0++oZdq+AnUA0dr/TM20KNc7DrkT7PMyEM27FxRYg8
         d6+c55CujUiAKaa+fwwR53JxBVsJVcmzQ/uFPwZLGgQji8wpcl3y7VDhMpWY6tjMaeTu
         txgw==
X-Gm-Message-State: AOJu0YzJmA3hofHKe/qaOU4rYlTkB/hKXajuObtS4MXooha2L4lkJC/Z
        D0my6XJT6uylISr7x+EU5Gg=
X-Google-Smtp-Source: AGHT+IG5S/ip7RUwzEiiwV3FfRhxwAfJzPoA0AHgoWOeXhvM1SNfgqC3HnPqI744GDUGdf3PgLP/VQ==
X-Received: by 2002:a05:6a00:21cc:b0:68e:351b:15b9 with SMTP id t12-20020a056a0021cc00b0068e351b15b9mr35521708pfj.4.1697151187538;
        Thu, 12 Oct 2023 15:53:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a118:bd3a:f198:d7ed])
        by smtp.gmail.com with ESMTPSA id a19-20020a637f13000000b00578bb0066b6sm2220692pgd.71.2023.10.12.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:53:06 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:53:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jeffery Miller <jefferymiller@google.com>,
        regressions@lists.linux.dev, benjamin.tissoires@redhat.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - fix fast_reconnect callback in ps2 mode
Message-ID: <ZSh40JethapBAjq1@google.com>
References: <20231004005729.3943515-1-jefferymiller@google.com>
 <ZR1yUFJ8a9Zt606N@penguin>
 <CAAzPG9Pp6mHfEziJiUuhDRmkKMfiiPD6axtfAMaCJcEAcuQPiA@mail.gmail.com>
 <25ac6b17-e3fa-4e98-95a6-eac12bdbcdd2@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25ac6b17-e3fa-4e98-95a6-eac12bdbcdd2@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Tue, Oct 10, 2023 at 09:08:23AM +0200, Thorsten Leemhuis wrote:
> On 05.10.23 02:13, Jeffery Miller wrote:
> > 
> > On Wed, Oct 4, 2023 at 9:11 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >>
> >> In fact, now that I think about it more, we should rework the original
> >> patch that added the delay, so that we do not wait these 30 msec in the
> >> "fast" reconnect handler. It turns out your original approach was
> >> better, but we should not be using retries, but rather the existing
> >> reset_delay_ms already defined in rmi platform data. I would appreciate
> >> if you try the draft patch at the end of this email (to be applied after
> >> reverting your original one adding the delay in psmouse-smbus.c).
> > I tested the draft patch and it works. I did revert the previous delay
> > patch while testing it.
> > 
> >> I think we need a similar change in synaptics.c as that one also can
> >> fall back to PS/2 mode.
> >>
> > Ah, good point, yes it does appear this needs to be done as well.
> > I have tested and will post an new version of the patch to include
> > the fix in synaptics.c as well.
> 
> As I'm affected by this problem (and somebody else reported to me in
> private to be affected as well) and nothing afaics happened in the past
> few days a quick question:
> 
> What's the way forward here now that -rc6 slowly comes into sight? Apply
> Jeff's patch to fix my problem? Revert the culprit and fix this properly
> up with Dmitry's and Jeff's patches in the next cycle? Something else?

I will revert the original patch introducing the delay now that we argee
there is a better way. In the mean time I will merge Jeff's patch to
reset fast_reconnect handlers, as it is right thing to do anyway, and
will get into shape the patch setting reset-delay in RMI code.

Thanks.

-- 
Dmitry
