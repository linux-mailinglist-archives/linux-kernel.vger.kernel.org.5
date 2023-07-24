Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621B75FF72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGXTBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:01:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A28188;
        Mon, 24 Jul 2023 12:01:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e6541c98so4441614b3a.2;
        Mon, 24 Jul 2023 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690225285; x=1690830085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytTgJxsf1t1AvxkCbddKWo4X3TXhqqtq1teyxCHoYOk=;
        b=EZi2+4C78YEQye1s/K5NqtUGVGXTSRHLCfjA3ZtxnAj785TEQHtjdQc8hTXfqDBp7u
         21EtjmGDvLleaQu1XM+NfAb0vg79SmB5i1xkIGwMpLv2cgS9gMvad54AOiJWoTIFnyh+
         08fX3gEJmuQDThegI6WwsyqDJCvYU2t4X3j4DWCUxCfLHPPGsCO1rH5UVNt6K2/asPCy
         42WudfHKFQ09DPP5yFnolnMRrbKRPH7Wdpzo4VmmrLqgRSqsW9GrmGoc07GKnscA+nfo
         DdWmNxpoo+j2sgsomqS8Iop03DJXdSNwqAfYAgK1HvzlgbmV5ShWkNnRT5M+A/kCeOvL
         vBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690225285; x=1690830085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytTgJxsf1t1AvxkCbddKWo4X3TXhqqtq1teyxCHoYOk=;
        b=QORIIl7QyLcFO6KiTzV7Tmf8KXAsVphjAO4VB6Uk31h4MKWp9WxsCANVTiuEJgvfvG
         kAKsCiSDKeK1RXblwnRwKQSI1CAEVTQU7MKJDzAPez9EsoMJWtRvYBlOc3BuCi/X06cM
         MOBOIHcS/K/wg1VNEEJrrrjwuS/BgTNhb49Iwor+Q055RQTItp0TG9n74zvH+vGfDlf3
         up1CLHuahb/7CpBXGr2bRg9KHMOxeo/JXMeDMJ2kddq6pkJlxfp9Zzo/wIqjYcusUBWr
         jk2afZjan0yGNgbYLO13jTNoc1+y6IkViB4FCKi4OgRok6i40P/hAKn8AB9RRdqt469x
         BU+Q==
X-Gm-Message-State: ABy/qLacVmoo472ib96JpY99MkIEkb/fx5HmsrutRbaDg1rpvmv9UaSb
        KlxP/8o5SdWMnTHrGvdXOKC9m/m//cg=
X-Google-Smtp-Source: APBJJlEnTwHHa2/VK6vUKdGrPE8+7iOUquvjmU858aF6UZE7WB0ArdiBb8M+6pBOVK/b2wvMvFdURw==
X-Received: by 2002:a05:6a00:1a01:b0:666:8cbb:6e02 with SMTP id g1-20020a056a001a0100b006668cbb6e02mr10845449pfv.8.1690225285294;
        Mon, 24 Jul 2023 12:01:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9d8f:da31:e274:eeb5])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0063f00898245sm2599472pfn.146.2023.07.24.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 12:01:24 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:01:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-input@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: lm8323 - convert to use devm_* api
Message-ID: <ZL7KghF8L+y1Fzcs@google.com>
References: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
 <20230724052901.350240-2-dmitry.torokhov@gmail.com>
 <b83df292-6f7a-a8bf-895e-6df80a17029f@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83df292-6f7a-a8bf-895e-6df80a17029f@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:53:11PM +0200, Christophe JAILLET wrote:
> Le 24/07/2023 à 07:29, Dmitry Torokhov a écrit :
> > From: Yangtao Li <frank.li@vivo.com>
> > +
> > +		err = devm_led_classdev_register(dev, &pwm->cdev);

                      ^^^^^^^^^^^^^^

...

> > -
> > -	for (i = 0; i < 3; i++)
> > -		if (lm->pwm[i].enabled)
> > -			led_classdev_unregister(&lm->pwm[i].cdev);
> 
> this look wrong.

Why? It will be cleared up by devm.

Thanks.

-- 
Dmitry
