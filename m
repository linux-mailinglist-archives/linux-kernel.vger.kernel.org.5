Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31CC7975D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbjIGQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjIGP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:58:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6620925
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:45:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso18762831fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101495; x=1694706295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avnDsHqUUU8nyVyXtMluY3OgsN1wqY/4LcZavOrvsJU=;
        b=iXYUVchIOXu7YATQ0BsYDLEt17+v2iqqd3fKxnTHehtXYOkfaj6E5Y1A2b+b6NNSB6
         0e07lQEs9yL/AbE3QHOwOUCLyKpZxJ61P2dFQRhY74MnHT/ls1wBd/t/SSxILw70TXQM
         mS07bfZUK36lvu8wKzF0nmgsO/AKlAfs5o+L/assmd+aOP66d/mi1eQ4tYhHWkYxyyKh
         ucxy58/vPmFk6WiYFuupnjvRDcdnvKwTOPpqvhSu/caGy5PCbxn+fc8Blq6ZfO4HAqxJ
         zbQ8H6EA66HO+vq6LBk94VHP/mRs6wz3332OjT60kV/yIY8aU/JPEaf3wGcnAIlHWkUE
         ZU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101495; x=1694706295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avnDsHqUUU8nyVyXtMluY3OgsN1wqY/4LcZavOrvsJU=;
        b=a59nue0OamTHNWwwNO9nLR+GpNN3u9heG7zo0HeZo+igyyjk4INuGYbYsie9x2n+Rj
         bnG0XxCYzpV2Nd/kq6REfv02s/rO/keBHC5LpqusqyAlqLqFdqxlTf1rjdhrgsJtD0qh
         NZKZkXovDZrEnuoxk0mHBkZhRPjW/TEYSnsS0OxcnBMS1dS3hMxdvqtajCW52FnOGS3K
         VM3yMfHdadgt9gUDuAc8c3bDUQOA0EJMrIVfBecnYGP3OB479P6KvweZPOhNuJ3NoSLM
         xjRBPkVmYzYC1JsolfSuZhEoZs1VMokCxGaMxAy9+qdZ9r0fbZQAzfc39a6Sb3E5EYPn
         J7lg==
X-Gm-Message-State: AOJu0YwiZ7d1r6pF6elhQ++XT2hhVTxYqENgTLTlZ+lZNGd0Jg5l4EeR
        Zn6in5NpjGIT3ODWRgC0+MauPQGL+hyY4pXPDf4=
X-Google-Smtp-Source: AGHT+IGQOLrWJEjGdkCr3Uovctlsb1sNon+44j0+R+x4O42FhjDtR6v0GBKKLVG6mZLLz1c6Fl+Q5Q==
X-Received: by 2002:a2e:9044:0:b0:2bd:10b4:c3e1 with SMTP id n4-20020a2e9044000000b002bd10b4c3e1mr4375344ljg.19.1694067859321;
        Wed, 06 Sep 2023 23:24:19 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id lo6-20020a170906fa0600b0099bd1ce18fesm10060916ejb.10.2023.09.06.23.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:24:18 -0700 (PDT)
Message-ID: <ccf7072c-cebb-0491-f07e-8c781a2f4664@linaro.org>
Date:   Thu, 7 Sep 2023 08:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nfc: nci: assert requested protocol is valid
Content-Language: en-US
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>
References: <20230906233347.823171-1-jeremy@jcline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906233347.823171-1-jeremy@jcline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 01:33, Jeremy Cline wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> ---
>  net/nfc/nci/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index fff755dde30d..6c9592d05120 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
>  		return -EINVAL;
>  	}
>  
> +	if (protocol >= NFC_PROTO_MAX) {
> +		pr_err("the requested nfc protocol is invalid\n");
> +		return -EINVAL;
> +	}

This looks OK, but I wonder if protocol 0 (so BIT(0) in the
supported_protocols) is a valid protocol. I looked at the code and it
was nowhere handled.

Original patch from Hilf Danton was also handling it (I wonder why Hilf
did not send his patch...)

https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78

Best regards,
Krzysztof

