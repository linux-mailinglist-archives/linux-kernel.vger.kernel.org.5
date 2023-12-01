Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186778004EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377743AbjLAHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:44:40 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AFFA8;
        Thu, 30 Nov 2023 23:44:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yilin.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VxY7s2Y_1701416682;
Received: from 30.221.128.92(mailfrom:YiLin.Li@linux.alibaba.com fp:SMTPD_---0VxY7s2Y_1701416682)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 15:44:43 +0800
Subject: Re: [PATCH] crypto: asymmetric_keys/pkcs7.asn1 - remove the
 duplicated contentType pkcs7_note_OID processing logic
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com, YiLin.Li@linux.alibaba.com
References: <20231111055553.103757-1-YiLin.Li@linux.alibaba.com>
From:   "YiLin.Li" <YiLin.Li@linux.alibaba.com>
Message-ID: <99c010f0-3bb1-1e67-4184-6b0ce312b232@linux.alibaba.com>
Date:   Fri, 1 Dec 2023 15:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20231111055553.103757-1-YiLin.Li@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


gently ping...
> The OID of contentType has been recorded in
> `ContentType ::= OBJECT IDENTIFIER ({ pkcs7_note_OID })`,
> so there is no need to re-extract the OID of contentType in
> `contentType ContentType ({ pkcs7_note_OID })`.
> Therefore, we need to remove the duplicated contentType
> pkcs7_note_OID processing logic.
>
> Signed-off-by: YiLin.Li <YiLin.Li@linux.alibaba.com>
> ---
>   crypto/asymmetric_keys/pkcs7.asn1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/pkcs7.asn1 b/crypto/asymmetric_keys/pkcs7.asn1
> index 28e1f4a41c14..3f7adec38245 100644
> --- a/crypto/asymmetric_keys/pkcs7.asn1
> +++ b/crypto/asymmetric_keys/pkcs7.asn1
> @@ -28,7 +28,7 @@ SignedData ::= SEQUENCE {
>   }
>   
>   ContentInfo ::= SEQUENCE {
> -	contentType	ContentType ({ pkcs7_note_OID }),
> +	contentType	ContentType,
>   	content		[0] EXPLICIT Data OPTIONAL
>   }
>   
