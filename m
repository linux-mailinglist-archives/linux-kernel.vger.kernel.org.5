Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D1752E61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjGNA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGNA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:58:38 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A2E211E;
        Thu, 13 Jul 2023 17:58:37 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55e1ae72dceso952775eaf.3;
        Thu, 13 Jul 2023 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689296317; x=1691888317;
        h=content-transfer-encoding:content-disposition:mime-version:cc:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3QvPholry1IqB1vPy7IfcSd36j1iZLv+L0ZuRD/FGM=;
        b=Od0sCmJxoe+HOJO//oPqNFMQHDQbiyO5KJSX3n/Etqnsf85dz8FGY8wrVsZ0vS/FyS
         9uhjgv3JPOlmCDtH9ZKL5n6IZbw5uW/OLw5VmjlAAMVPnfevyOqh5b3Xcl3Du1A05zkP
         z4KZzutdQ68vlAWVV8NTDvy7frxN4IRdFe05Hd3GJ7mIC9WNLWFVD55uGuutjgK/WrzI
         MdhJUwU+usouTRejSO8Nux8JEhXtEo8gCCdgafOEoQ+jQi5PxjTFIoeEEgJzfIk/Ij5e
         83zuPUnAZz9St92Epnm8kbs2yj4OOLkFrw/P+GDZQpnTSgEgoKRB/vvFCuwjtwzrXXlm
         g18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689296317; x=1691888317;
        h=content-transfer-encoding:content-disposition:mime-version:cc:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3QvPholry1IqB1vPy7IfcSd36j1iZLv+L0ZuRD/FGM=;
        b=AeYD0PvXNB77jLP7xH34pTFDw1akLhP6RPOdkcany51XGL7A5iP7kQSdfoH7Z1TuEC
         L75MwcyupdG9e7ts7a6KumTDLoRhEjgsXcsX7taYbA4nF46BO6pINCsiH10vCZMcYHcb
         WZC4lUOqAicQJJ3huzxnNTjlw76pUFB3gM0MPeYWyQB05kbLMUT8CbCCYNmh7CclFIQN
         snE/FoPGQDrOy1pJ+9lZBb6/ciBwnwAVNuakbuViJQD8pFRo7kW/hhHkY+DSFzn7eWZ8
         qs2datnpxg4Do2FkyTRVhNfglL29O5EXv5IAJF48XDrheY4t5TysNPKRYrbV4cr0fBF6
         7XtA==
X-Gm-Message-State: ABy/qLajYVRbXLf+zunMo08/upLy8Pw2BHkpXgZP9l3BtpOI5m5ALsf1
        wk/Sgvuuihqnh2XXjkIwymE=
X-Google-Smtp-Source: APBJJlFrFGPeV2v/lahcV5pOQNJoQYWQf1yvMi7CyGI3CFAmU7imqJAnCuy8p5rp5JodRd7tqir6RQ==
X-Received: by 2002:a05:6358:52c1:b0:134:d026:42d2 with SMTP id z1-20020a05635852c100b00134d02642d2mr5022104rwz.24.1689296316493;
        Thu, 13 Jul 2023 17:58:36 -0700 (PDT)
Received: from oa-luoruihong. ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id p1-20020a63ab01000000b005348af1b84csm6242754pgf.74.2023.07.13.17.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:58:35 -0700 (PDT)
Message-ID: <64b09dbb.630a0220.e80b9.e2ed@mx.google.com>
X-Google-Original-Message-ID: <20230714005829.GA45908@oa-luoruihong.>
Date:   Fri, 14 Jul 2023 08:58:29 +0800
From:   luoruihong <colorsu1922@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MISSING_SUBJECT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gregkh@linuxfoundation.org, jirislaby@kernel.org,
linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org¡¢
luoruihong@xiaomi.com,
weipengliang@xiaomi.com,
wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
In-Reply-To: <ZLArgoe3TXF27gsE@smile.fi.intel.com>

On Thu, Jul 13, 2023 at 07:51:14PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 13, 2023 at 08:42:36AM +0800, Ruihong Luo wrote:
> > Preserve the original value of the Divisor Latch Fraction (DLF) register.
> > When the DLF register is modified without preservation, it can disrupt
> > the baudrate settings established by firmware or bootloader, leading to
> > data corruption and the generation of unreadable or distorted characters.
>
> You forgot to add my tag. Why? Do you think the name of variable warrants this?
> Whatever,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Next time if you don't pick up somebody's tag, care to explain in the changelog
> why.
>
> > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> > Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>

I'm sorry, I didn't know about this rule. Thank you for helping me add
the missing tags back and for all your previous kind assistance.

--
Best Regards,
Ruihong Luo
