Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779837AD684
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjIYK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIYK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:57:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC9B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:57:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50307acd445so9628516e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695639443; x=1696244243; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edHM5CZ8HXnUMh35tJgNkdAVLb7EQO0eeFfjzYsKx/0=;
        b=DZUG/8miAei0msHDvcF1LRd2/A/uQgOeJtHnGRFO+P8VkgaT4sDJUHxNnwiaXDhI7s
         upSNjST3IHtwhvc3qVSW8ctxin9f1Wpe1FWdki5XrV7sU8SOfH9rbQm0PZg6siv0p8+h
         cH0sw8e0ZL9AQSlvYjFatE9k6nLdNVlvZjt9d/fHAi/N0YqfTIILaNl01Kniy+kEQTz4
         b+vUmgC1hL5ecnv2+d+cxL0Zjd0K/Q+UVhuNuTorvrzO9QeHvBVFkwC1W6gdovb6xsSt
         owIVbZ3kqKHOqKXwSK0YEGDrZ8K0DDomFDUsDXZg4buO+LRzgI3Fs9kiXj2+xhxqX1sX
         Ay6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639443; x=1696244243;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edHM5CZ8HXnUMh35tJgNkdAVLb7EQO0eeFfjzYsKx/0=;
        b=JY9tYVqhf6M5CRfMTvJO0Qfjtm1Xl/8sIfHkyAEIpLjnJoQjs/hsYie6sm3jciRuWx
         GQFKvSbxRNX3CzfV4cs8aGOLOUI1CY7zMEE22mjFv+11q1jrwh/NO6OmR1Ag3gGoGfb/
         6Hosm3mPlsmkYjD0Xgi4Q8Clz3TNeYuZsD+0Vcir3yqB/JYA8JPzMKvaDiUDLKeSsKN9
         +BYGdr2ZhHxuPaV1KOm3jUEPVIDMtKY68IHVoyXpJ8CD4vb1/EFJWgRFbSOOm4enk5IT
         5JvEgsIBIPTIGrDttvy11mn1/L5Mz1EQ8c3lFkrOy2+1mhU3+e1FlcHWuasqO1F9G5/S
         Po/w==
X-Gm-Message-State: AOJu0Yz6VwJMgOegg0zXwb/wYcn7FfH386OmOWKWKaou+gcZHudaUaU1
        wO11MI9Pl5Vr4OYXN0wWmDDQ4JB44Ih0KjOA/f5sA2mC
X-Google-Smtp-Source: AGHT+IFYRbM/bOeFWN4sEZmDfqgvIkoZVgsQ+BEygw3lcSr9bY3C21AWcQnCcLNtKAweVKXKzbnBQAJotNO2rF2DV3g=
X-Received: by 2002:a05:6512:104c:b0:502:9fce:b6e0 with SMTP id
 c12-20020a056512104c00b005029fceb6e0mr6488404lfb.28.1695639442615; Mon, 25
 Sep 2023 03:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANpxKHHzre03bFfW_UpJy1W40oFa6Q6x688WrCXKtNeqkeVk7Q@mail.gmail.com>
In-Reply-To: <CANpxKHHzre03bFfW_UpJy1W40oFa6Q6x688WrCXKtNeqkeVk7Q@mail.gmail.com>
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Mon, 25 Sep 2023 20:57:11 +1000
Message-ID: <CANpxKHEDD+fjQiH=DrHPWTm6CMkT78Tcbk2sVfPydO9+M2-FQA@mail.gmail.com>
Subject: Re: Small MSS in vmxnet3
To:     kernel derkeiler <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
could you please let me know any ideas?

Thank you,
Kind regards,
Bao

On Sat, 23 Sept 2023 at 12:12, Naruto Nguyen <narutonguyen2018@gmail.com> wrote:
>
> Hello everyone,
>
> Recently I found that packets sent from vmxnet3 driver on guest have
> MSS value set to very small size, some 10 bytes, some 25 bytes MSS.
> The vmxnet3 NIC enables TSO. Could you let me know any possible reason
> that the packets are fragmented with very small MSS.and is it normal?.
> Any way to avoid this small MSS or it's just normal.
>
> In addition, when enabling debug for vmxnet3, in function
> vmxnet3_tq_xmit, it has a printout
>
> netdev_dbg(adapter->netdev,
> "txd[%u]: SOP 0x%Lx 0x%x 0x%x\n",
> (u32)(ctx.sop_txd -
> tq->tx_ring.base), le64_to_cpu(gdesc->txd.addr),
> le32_to_cpu(gdesc->dword[2]), le32_to_cpu(gdesc->dword[3]));
>
> could you suggest an easier way to extract the MSS value from this output?
>
> Thanks,
> Kind regards, Naruto
