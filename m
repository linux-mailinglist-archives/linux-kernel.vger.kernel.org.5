Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98123752C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjGMVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGMVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:47:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B415172C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso2376675e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689284820; x=1689889620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcefY1X0SEJeyGFbpnphfYhJuGzSUZJNnB/pOHxnr1M=;
        b=YQeeH9gfps3abtFe8Tr40m0Vd3JMakI3A7R1YLeGg+eVQDcOPpd9KLkPJK2QDcY2cD
         b1c9TC7DSZkEQA5/j3a6cwZxST1Nb5mm3ngnRWgx9GTWWxNqob9dr/xz9AaIG4Dx3t8f
         WkAgckJ8YMof6tjNz6nDGwL/ngpvng9KVmxJUxXfyMQKdC2kBSFnPlSw99aiLjhKuH8W
         bVBpafJiKngugZfogn+u1t/Dn2PNDRE7dGYA9H48N8u2QJl2QBEUDWyRMazw6eFT19IC
         1C3nfhSgoTCQEGXK5bE3nDoxZiq5MB3r/6auGx9Sx6SaWa5quZLT/My1wN3x3YKzIVwd
         N00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284820; x=1689889620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcefY1X0SEJeyGFbpnphfYhJuGzSUZJNnB/pOHxnr1M=;
        b=MMYjgeYwEmRj4QNUt5AvDM2Mj1eNIZA3bzHpNAdBs8nTKR+YIAl9N+l1C6X5x+yWOd
         Aww67NR3zw6b4nb2qXm3WkGxzr56HlC4l6zJ7Y3/vieQswoAQTYz/m8ta4GskAP3QlQN
         1g7HH6F/kSk4/vGY9fA4rotm8lj3Eu0s14q0fK8eKyO5p9oiXmFYOdm6G8rufpQ5a1bz
         FRJWy/MQhZ3H079hLw6OvpnSEYQiAw4YLFCqNrm3El1q8qyg7fuZG8J4sJvF5zzvSOqU
         ONc995xjPTZUKhwltEasJzstkJNljUJIS1lUvcaBQIPtPNLDPcvIdcp3bPfauMypqnn0
         2JkQ==
X-Gm-Message-State: ABy/qLa0DlR4moEqciuol7zcdl4KDuAB1UZoy/5OidzkklWidRTdhMXo
        Sp5iSjNWz/UhRog8YBbOaJk=
X-Google-Smtp-Source: APBJJlFG6OEYgfLkp1K8WaXCHczGAbzqahq8/Hh6eP8S1DJmeb8Zk4+MnX+Ad24amCku3Acnr/Jw8w==
X-Received: by 2002:a05:600c:5192:b0:3fb:3dd9:89c with SMTP id fa18-20020a05600c519200b003fb3dd9089cmr2617991wmb.0.1689284819428;
        Thu, 13 Jul 2023 14:46:59 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003fa74bff02asm22989wmj.26.2023.07.13.14.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 14:46:58 -0700 (PDT)
Message-ID: <dd078125-8287-4d83-a9f7-4acf6435bd18@gmail.com>
Date:   Thu, 13 Jul 2023 23:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/12] Staging: rtl8192e: Rename function TsInitDelBA
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZK83kk5tQWqdTvXz@basil>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZK83kk5tQWqdTvXz@basil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 01:30, Tree Davies wrote:
> Rename function TsInitDelBA to ts_init_del_ba
> in order to Fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 2e37f1e949ec..9a32528fe314 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -484,7 +484,7 @@ void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
>   	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
>   }
>   
> -void TsInitDelBA(struct rtllib_device *ieee,
> +void ts_init_del_ba(struct rtllib_device *ieee,
>   		 struct ts_common_info *pTsCommonInfo,
>   		 enum tr_select TxRxSelect)
>   {
> diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> index 7841d9ce1a7f..8005f7462aca 100644
> --- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> @@ -396,7 +396,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
>   {
>   	del_timer_sync(&pTs->SetupTimer);
>   	del_timer_sync(&pTs->InactTimer);
> -	TsInitDelBA(ieee, pTs, TxRxSelect);
> +	ts_init_del_ba(ieee, pTs, TxRxSelect);
>   
>   	if (TxRxSelect == RX_DIR) {
>   		struct rx_reorder_entry *pRxReorderEntry;
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index de0dd48d0646..42a9b1dafc27 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -2010,7 +2010,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
>   void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
>   		 u8 Policy, u8 bOverwritePending);
> -void TsInitDelBA(struct rtllib_device *ieee,
> +void ts_init_del_ba(struct rtllib_device *ieee,
>   		 struct ts_common_info *pTsCommonInfo,
>   		 enum tr_select TxRxSelect);
>   void BaSetupTimeOut(struct timer_list *t);


Hi Tree,

we need to wait which patches are accepted. I cannot apply this patch on 
the top of the patches already send and I assume those are accepted. See 
below:


kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply -v 
~/Downloads/20230713-\[PATCH\ 05*
Checking patch drivers/staging/rtl8192e/rtl819x_BAProc.c...
Checking patch drivers/staging/rtl8192e/rtl819x_TSProc.c...
error: while searching for:
{
	del_timer_sync(&pTs->SetupTimer);
	del_timer_sync(&pTs->InactTimer);
	TsInitDelBA(ieee, pTs, TxRxSelect);

	if (TxRxSelect == RX_DIR) {
		struct rx_reorder_entry *pRxReorderEntry;

error: patch failed: drivers/staging/rtl8192e/rtl819x_TSProc.c:396
error: drivers/staging/rtl8192e/rtl819x_TSProc.c: patch does not apply
Checking patch drivers/staging/rtl8192e/rtllib.h...
Hunk #1 succeeded at 2004 (offset -6 lines).
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$

So better wait for Greg to choose which ones will be accepted.

Bye Philipp

