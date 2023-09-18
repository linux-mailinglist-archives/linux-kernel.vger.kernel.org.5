Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7E7A5393
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIRUOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:14:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96531B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:14:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so29834891fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695068087; x=1695672887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foir4CYi7UwePbsanUl7EqFTPVU+gOMJyfvtDpuR/qE=;
        b=ES/kj03omgUBweTWniF9JePXJdplALuWIpGyAJZPQIYSX/R7aS4wIIb05OxcM98I8D
         Oa6qeB/Z1qc2Yk+KWOVqRdSzzKgEwJ77Yf7YEBrnk0o4ts3raoaHq6/V7nLDJDPK9eVI
         WxOSV0151SAm2DAZj7RAldPdYaLhameaVbVXJAR8KU/OS4mCYkqqIVcN6PD/czfx8od1
         DwK1KhVFvoj0ZTqOQehBKqAWHi3w8zCPMt6TEZUdLEDELCQQIz6YGE2vS2hPly/jBZcY
         FcLqHw8OP1BDHZ2SzfLymYwUvJGoQ3uO2raDAvKTHw8FSF9PSidl/4FLvHgXzEeZ5nSN
         yKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068087; x=1695672887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foir4CYi7UwePbsanUl7EqFTPVU+gOMJyfvtDpuR/qE=;
        b=XYN32+Iwp2qw5pb5EAomYXo+r65oIZTsaaijnnUEiFskDX0uxadI95o4yWxOF6wSyF
         bhn77HZMu6yXE7Rp1pvw1/btI76i5KfqhMFZM3CIB5diYxXozibCQkCjSTAJTqV2P7xx
         DzHw55tWIHKkKfmifJvbtNXUNNCpzKJ+1yBy0l12KjbSSSQNfwc6pbwE9hpkm4F1OTVB
         DtiCDnSTD2SaisnAdVTPfXwgpgJ7UN0MOO6X2AOF9Gs908h1j46evb2xN2z1yRU+fYOc
         AVuLTBMLci4PsQSch0y2R3TJn8gU1TDS5l4JX63InVXQ0F1VeK2dej5ZJtz1QBpo7Rpr
         loAw==
X-Gm-Message-State: AOJu0YxXxWa7GF1QBrd+ij/EEnd0TFXPs0UBsHEQGDJcY+RWF6dBFrTc
        T/DUHuYTW155LCrLd9gkE7g+Xw==
X-Google-Smtp-Source: AGHT+IESNYwKw/yvTzkMUYIbu+kKT964yTO8C2nh7iIsPR3ZHyrUuYIec+59pv6vLgQaJn81wkR3SQ==
X-Received: by 2002:a2e:86c2:0:b0:2b9:daa4:f4b6 with SMTP id n2-20020a2e86c2000000b002b9daa4f4b6mr9066399ljj.45.1695068086835;
        Mon, 18 Sep 2023 13:14:46 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b00992a8a54f32sm6792638ejb.139.2023.09.18.13.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:14:46 -0700 (PDT)
Message-ID: <7f5021c9-49a8-ad06-5a48-1d531dbda12e@linaro.org>
Date:   Mon, 18 Sep 2023 22:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 6/7] dt-bindings: media: wave5: add yaml devicetree
 bindings
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com>
 <30384744-94d7-2675-63ad-d8531e3156d1@linaro.org>
 <20230918064954.iuomunsckduawiay@basti-XPS-13-9310>
 <6d87034e-6727-09fd-60fc-10f8ca47f85b@linaro.org>
 <7412a756ee4c83c62b3dc866b5a351e1bc4afa33.camel@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7412a756ee4c83c62b3dc866b5a351e1bc4afa33.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:16, Nicolas Dufresne wrote:
>>>>
>>>> A nit, subject: drop second/last, redundant "yaml devicetree indings".
>>>> The "dt-bindings" prefix is already stating that these are bindings.
>>>> Basically three words bringing zero information.
>>>
>>> Okay so:
>>> `dt-bindings: media: wave5: add devicetree`
>>
>> Still not, because devicetree is duplicating "dt". It's redundant.
>>
>> Instead should be (with correct order of prefixes):
>>
>> media: dt-bindings: wave5: add AzureWaveFooBar XYL ABC10 (whatever
>> company and full product name it is)
> 
> So maybe this one ?
> 
>   media: dt-bindings: wave5: add Chips&Media 521c codec IP support

Sure, sounds good for me.

Best regards,
Krzysztof

