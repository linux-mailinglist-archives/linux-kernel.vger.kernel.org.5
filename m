Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C067C935C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjJNH6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJNH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:58:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8EA9;
        Sat, 14 Oct 2023 00:57:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso21867221fa.1;
        Sat, 14 Oct 2023 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697270278; x=1697875078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3JZBj8UNE1RTHFSrGe4HMHkrU5m6j5rUcUwl/TMX+o=;
        b=QlMlXx8H4zON5JiYEUp/FsEZH4xm4ZLD9akxFAE/hSULXC+QzapSC8M9PxTpVeEx0m
         6XgwGZ5IJNFBcY+fts1ZFSK084PR8jsq3Ol3w9VD5Efb3UxrXSbfrthLiN8sN0KMeaDF
         aDLWK85xdkWpLPcDqDOZCjpvwF61FCKGrF33qxrLpQEQXKQRiu4mtyASizU5v78Hyxza
         ZxrlHgWoU0mv/WcK3UZu9HPpMOmMs18xWAai2QvdrK7elKYNV9zQHuiuAadR6WbAwrGv
         w4jrx0drzDX8rLbGlx389/4cCshJtX/W3i4vLarb34iATZOJKnhth678Na/NX3Pg6hyt
         ejRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697270278; x=1697875078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3JZBj8UNE1RTHFSrGe4HMHkrU5m6j5rUcUwl/TMX+o=;
        b=DknY5Zm1Vpj9OdDKypuXT8PEQbAJE/b/rfcSKUPk9pOK43ZIQAihJFk9MgQOcI8NlY
         RI73wDkMDZrWEgwQn/t0LWUP90vAA8FLtpPae+tXpI+fdUtuH1nC2Vu44B5DnbK2YX+2
         ukxmz9zSdfUOJ112SKkGyKnRs5awv9OyJXlpBbuMrnLX78BGWryobwLZfosx6dhw/Zm3
         e9XeVlfGVH4m/FFUQGOjFm3CFauvH/Tb9AfuJMsabsctUzNbt1tcxLJRvTQfMnXpY7ZY
         49k7vML3/l1MdTSvwcAu0VSYuf/8DyEkJ9Px8dSijFws38BKVrCe8Jz0mZlYTU/20/J4
         T+Tw==
X-Gm-Message-State: AOJu0Yxf51QTt5e0hDgOl19BVd5BDZB7tya8WjrEuX+fdmTnCZw1v+Nf
        92alOT4YFklhirLqrSltw2E=
X-Google-Smtp-Source: AGHT+IFNZ1nV0qSzhj6MXHIF3QUnomqhsFId7lwvnws0J30v164Wymh8pA0iZMyBijF2l1bp7MtYcg==
X-Received: by 2002:a2e:a9a2:0:b0:2c5:32b:28ea with SMTP id x34-20020a2ea9a2000000b002c5032b28eamr4145909ljq.32.1697270277851;
        Sat, 14 Oct 2023 00:57:57 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:57e7:d911:5fee:d153? (2a02-8389-41cf-e200-57e7-d911-5fee-d153.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:57e7:d911:5fee:d153])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c4b9800b00405442edc69sm1289370wmp.14.2023.10.14.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 00:57:57 -0700 (PDT)
Message-ID: <973e87e1-13a5-40d2-9917-ed1984fb9edd@gmail.com>
Date:   Sat, 14 Oct 2023 09:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: bcm5974 - check endpoint type before starting
 traffic
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
References: <20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com>
 <ZSoFDLv8_CG1SGN6@google.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZSoFDLv8_CG1SGN6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 14.10.23 05:03, Dmitry Torokhov wrote:
> Hi Javier,
> 
> On Thu, Oct 12, 2023 at 06:51:49PM +0200, Javier Carrasco wrote:
>>  
>> +static bool bcm5974_ep_is_int_in(struct usb_host_interface *iface, int addr)
>> +{
>> +	struct usb_endpoint_descriptor *endpoint;
>> +	int i;
>> +
>> +	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
>> +		endpoint = &iface->endpoint[i].desc;
>> +		if (endpoint->bEndpointAddress == addr) {
>> +			if (usb_endpoint_is_int_in(endpoint))
>> +				return true;
>> +		}
>> +	}
>> +	return false;
>> +}
> 
> This essentially reimplements usb_find_endpoint() in a sense, so can we
> instead do:
> 
> 	ep = usb_find_endpoint(iface, addr);
> 	if (!ep || !usb_endpoint_is_int_in(ep)) {
> 		dev_err(...);
> 		return ...;
> 	}
> 
Thanks for your feedback. usb_find_endpoint is a static function from
the usb core and in principle is not available here, but your code
snippet seems to reinterpret usb_check_int_endpoints() for a single
address. I would suggest using usb_check_int_endpoints and pass both
addresses at the same time (if both exist, of course).
> 
> Also it looks like the handling of button endpoint is interleaved with
> the trackpad endpoint, I wonder if it would not be better if we have a
> separate "if (cfg->tp_type == TYPE1)" where we would do the check,
> allocate URB, and did all the rest of set up for button transfers.
Using usb_check_int_endpoints would solve this immediately.
> 
> Thanks.
> 
Thanks and best regards,
Javier Carrasco
