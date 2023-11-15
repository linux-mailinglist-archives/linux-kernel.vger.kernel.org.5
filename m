Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD27EC869
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjKOQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjKOQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:21:23 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFA1BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:21:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so100212771fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700065278; x=1700670078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVv1D9dMzK2tGtDx8E6+Meyyl7KM9X9Cid8vZyXVWLQ=;
        b=nkWcuGjHWJlB5oS6s7QCKl3FJKD8BYVs9YdjKPKINd9d1LnpFfakwqEXoBS7xW5Nt5
         Gtcc37cKfSDpibVFQ2NsQLabGSJ2a4xAJ3BY+g5hEQHo505zfTZGvkKfY90pQ0BrqgOg
         sqAg1UIbM9In5PqbYpkX0DSsgDCzkAYFGUhfBPqAirROTXdLQBZ2m5iFBWKa775OEjpD
         y72smCeEQIzruatQXYPlhJEvptIWmrYSb0kq0GKwiYZCgqK1BkAIM624D/gHbsmhKmO7
         EGbE7NkgOfSu2eKZ5qlTTLcM1xmHkk9S2GnrhOHnD2j/z1KeqPJHXp2j352wQ/Y8INFf
         tqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065278; x=1700670078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVv1D9dMzK2tGtDx8E6+Meyyl7KM9X9Cid8vZyXVWLQ=;
        b=HJRmrf76CB14N1BK2rWKgFtHJSbjMHCgoyGnWYp9Teqh3B4n3JvcRmI6oVFZ//QjSL
         9J/upXzk+GUIc1efg9ULZpb5xlRIw64/TndGEzaXd8musENNwLnVsXqE0CFPRLNwycnP
         b1ybijYHg7mCiizQOlP1nW7QGUfOP1g0C03uaWHFeMpxsSWFm2PMQ5TkRCQeqqihMKF5
         LndlcSx1ZRos+IV/30LDTc2i1WSuoEpGLs0cVa8l5RffjGi+Hwrm95TlHgAXS6ReAWPk
         KnXqE9lydee8ZDkWb4ndWhKzf7mwhFlWTTQ6uD0hJ8GX0hS9afve37XEcFAqICoUWtoZ
         P2XQ==
X-Gm-Message-State: AOJu0YzKEve0aRilx2ilvHy6RB5GUZViHRh+QC7NsV0Wmjf4ToU6sSjq
        /clV7h4Av00aE9WL4jhu3EomLg==
X-Google-Smtp-Source: AGHT+IFCLx6HHI+jGJHV1et2rTKGgSRQshmq5seiuQChkp/OhZAw87J/KqKNvRdslV7HkciiBmhLaA==
X-Received: by 2002:a2e:7811:0:b0:2c5:1e70:7d30 with SMTP id t17-20020a2e7811000000b002c51e707d30mr4743696ljc.30.1700065277935;
        Wed, 15 Nov 2023 08:21:17 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651c0a0800b002bce77e4ddfsm1699622ljq.97.2023.11.15.08.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:21:17 -0800 (PST)
Message-ID: <e603c4ef-d834-4d23-81a1-abe6ba45d61d@linaro.org>
Date:   Wed, 15 Nov 2023 17:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dt-bindings: connector: usb: provide bindings for
 altmodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
 <ae5131e3-b282-437d-9a80-ae8b697eea3c@redhat.com>
 <CAA8EJpq_vXefsNHmUCopmyATF8=PsjG0-EwJCY65yfvkCK+A4w@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpq_vXefsNHmUCopmyATF8=PsjG0-EwJCY65yfvkCK+A4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 23:13, Dmitry Baryshkov wrote:
> On Mon, 13 Nov 2023 at 18:07, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Dmitry,
>>
>> On 11/13/23 15:33, Dmitry Baryshkov wrote:
>>> In some cases we need a way to specify USB-C AltModes that can be
>>> supportd on the particular USB-C connector. For example, x86 INT33FE
>>> driver does this by populating fwnode properties internally. For the
>>> Qualcomm Robotics RB5 platform (and several similar devices which use
>>> Qualcomm PMIC TCPM) we have to put this information to the DT.
>>>
>>> Provide the DT bindings for this kind of information and while we are at
>>> it, change svid property to be 16-bit unsigned integer instead of a
>>> simple u32.
>>
>> Thank you for your patches. I'm fine with this, one remark though:
>>
>> Since at least the existing arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>> is already using this I'm not sure of changing the svid property to
>> an u16 is really a good idea from devicetree compatibility pov ?
> 
> Usually we try to keep DT compatible, that's true. And I also do not
> fully like the u16 notation. However I'm not sure whether using full
> u32 for explicitly u16 value is correct. I'll wait for the guidance
> from DT binding and USB maintainers.
> 
> I'll mention the qrb5165-rb5 explicitly in the cover letter.
I'd say it's fine since it was incorrect from the start (+ bindings
shouldn't describe linux's flaws)

Konrad
