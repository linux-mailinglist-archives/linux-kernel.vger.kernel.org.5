Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C0752EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjGNBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjGNBtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:49:00 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B8B2694;
        Thu, 13 Jul 2023 18:48:57 -0700 (PDT)
X-QQ-mid: Yeas43t1689299276t121t06280
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.133])
X-QQ-SSF: 00400000000000F0FPF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16226584020387075153
To:     "'Wang Ming'" <machel@vivo.com>,
        "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <opensource.kernel@vivo.com>, <opensource.kernel@vivo.com>
References: <20230713121633.8190-1-machel@vivo.com>
In-Reply-To: <20230713121633.8190-1-machel@vivo.com>
Subject: RE: [PATCH net v1] net: ethernet: Remove repeating expression
Date:   Fri, 14 Jul 2023 09:47:55 +0800
Message-ID: <000a01d9b5f5$3591e8b0$a0b5ba10$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0yjQuFQ/A5lRuvqU7vaX0n2FvbK8CVZYw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 13, 2023 8:16 PM, Wang Ming wrote:
> Identify issues that arise by using the tests/doublebitand.cocci
> semantic patch. Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 39a9aeee7aab..6321178fc814 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1511,7 +1511,6 @@ static void wx_configure_rx(struct wx *wx)
>  	psrtype = WX_RDB_PL_CFG_L4HDR |
>  		  WX_RDB_PL_CFG_L3HDR |
>  		  WX_RDB_PL_CFG_L2HDR |
> -		  WX_RDB_PL_CFG_TUN_TUNHDR |
>  		  WX_RDB_PL_CFG_TUN_TUNHDR;
>  	wr32(wx, WX_RDB_PL_CFG(0), psrtype);

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

