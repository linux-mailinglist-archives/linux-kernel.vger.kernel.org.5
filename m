Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AB575B7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGTT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGTT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:27:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A71737;
        Thu, 20 Jul 2023 12:27:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so10269625e9.2;
        Thu, 20 Jul 2023 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881261; x=1690486061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsXKzGCpPd/p0NpJWJyfXcpB0p1qO6kuAeJPo9pRHz8=;
        b=FC2UDsB2l0hVoQPYI9EaVjbA1dBtyRq1speteEPE57yHsGt3UxpctS4msEZKbXfwYa
         NI4IvIhKA8GDMEKf0FIquaU4W0aL0R0MsDs4uCZybjBDvvXDipxC90/in33+VqYj6yhw
         5sMxUL7v7d7pIamQ8w/vkfZO8iynqMM4I/9gnglF7O2GnmftWESC6ad/MP9l0nD0xZZf
         sZ5tLYeBGDPSP5/1d19bCRpOC3kvNgO2sqkTrR6uewg1Ee2tzLQaq5cEHhgBHaSS5syA
         qvXLFEJShbWXu8YeFGzehFTVRRAHjMXKI/w/K6Fnx8WWvAdIcRN90rV4jZZY8ECyvClv
         px+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881261; x=1690486061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsXKzGCpPd/p0NpJWJyfXcpB0p1qO6kuAeJPo9pRHz8=;
        b=b1RIkzSeYXpdGVf2MUCP4GzHfjrN3KEj5NPMrtUhdbTWMOvKRSa7o8fyyWI7fBKqv9
         HBQ+wY0Uzxqy9nhUgIVSdsUL8ZV7FkrNfXmfDI51mDkWZ/ZoGHjZi8+J4i3N46JtWEvt
         pubedyfHsmG/qaEFoyPFQpaS8wq1mu5qiGnD5/NJiXgLz8WghWBfrvGD2pQkKxdal3Im
         nrxkEi8IYJEY1kv/39nHOMiFVmazwrhJcr87zwG7wwwloWsyQgHgujrKq8R2fSonxxYW
         V4r+emUfVBxUbMPZpfdeoDVgjXQSwMv8hvp6CW/1OhxMIRl1tiWR7lUKKrirQ/NkaI97
         Yy9g==
X-Gm-Message-State: ABy/qLaRoksxFaj9lNBU8638xdlOIgL6WcfeWG0Kbf3sGtzWtOy7qYaW
        zl8i77IB1rJiZcfMNb74kxj9etld8kE=
X-Google-Smtp-Source: APBJJlGdVw6ytJB75Am5CzETRLxhNN6VWlweZujl5l3wTTu1KxZUNbyIS+aAv6C6ZXbw45yPirJKmQ==
X-Received: by 2002:a1c:7318:0:b0:3fc:a5:2c3a with SMTP id d24-20020a1c7318000000b003fc00a52c3amr2542995wmb.41.1689881261377;
        Thu, 20 Jul 2023 12:27:41 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b0031423a8f4f7sm2104079wrk.56.2023.07.20.12.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:27:41 -0700 (PDT)
Message-ID: <9f50e6c7-5c85-f70f-a5fe-19923d28f770@gmail.com>
Date:   Thu, 20 Jul 2023 21:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-4-luzmaximilian@gmail.com>
 <ZJwjWoxm3GDkJ0cm@hovoldconsulting.com>
 <ZJwspnWhpOCJ88WP@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZJwspnWhpOCJ88WP@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 14:50, Johan Hovold wrote:
> On Wed, Jun 28, 2023 at 02:11:07PM +0200, Johan Hovold wrote:
>> On Mon, May 29, 2023 at 01:03:50AM +0200, Maximilian Luz wrote:
> 
>>> @@ -1496,6 +1903,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>   
>>>   	__get_convention();
>>>   
>>> +	ret = qcom_scm_qseecom_init();
>>> +	if (ret < 0) {
>>> +		__scm = NULL;
>>
>> So as I mentioned in my reply to 2/4, you can still have clients
>> registered here when you clear the __scm pointer which they rely on
>> after an error.
>>
>> Not sure how best to handle this, but perhaps registering a qseecom
>> platform device here and have it's driver probe defer until scm is
>> available would work?
>>
>> That way you could also separate out the qseecom implementation in a
>> separate file (driver) rather than having the ifdef above.
> 
> An alternative may be to just warn and continue if
> qcom_scm_qseecom_init() fails. It should never return -EPROBE_DEFER
> anyway, right?

You're correct. That would be the simplest option. Any error returned by
qcom_scm_qseecom_init() comes from the client registration part
(qseecom_client_register()) and is either -ENOMEM or whatever
auxiliary_device_[init|add]() returns. As far as I can tell, the latter
errors out either on invalid inputs or on OOM, so it should be completely
fine to just warn about it failing.

Regards
Max
