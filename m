Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6EC80D0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjLKQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbjLKQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:16:12 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13031198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:16:16 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67ea7dbd51cso24933346d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702311375; x=1702916175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
        b=QhHAruhHDJwS1YqCWWOQjZe6vFaNZl9vgrCfr2rLk9334kqkidfz2I6xFi2MqCplRK
         HsRzepNc+fum+8+RIuauotY7cHATmK/eMKsnfV8ms2fP6nSNVCqcFUC7zmC/Nkm9ZwWW
         f0ZiLblbVR982iaPGxCRzOj8zDxoJ4o+hU+HdQ5znBuUlKgjWrSAaeO+z8su6MlRihKc
         keIHTLn2X4M+dJx5N5IkONalQ9m0AUtZJWKh8W8zBfA9PSke2nihsWQl1/fH2SRMuHg1
         P4W4zt4SWofkbaBfwPZsvWksGts4NRS9buQk1JL+imD4BcQ33oW2Cj5/lepwoN1nia0g
         ZABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311375; x=1702916175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
        b=q5/oHNSB7yANXeogNQPkhISBJMtS7nszlYgm0t/TfTMGiWiJs+9CBmNoW5zLiq05Si
         BIVH1MBgIUKlrNPlfT2OKnsQ6wkn3RpPcCNcmL/+8FY8kL5E5gIAe5VAngqxI2Yoi98P
         zqtVD5q3bOZv9ji4JakeSvDNTKKLpWK2cc0CFQsRhW0qwRXpQzqhcAyVFSiaYPrdvnkb
         ziadIF8tMO3lbGbOO0R3gvcV+oYYVebX0j8AzFLTSD0I2lazq7Wzbpl/+RkgJzwyF/qF
         68aBGKvlo1+Y96oFtAyXBGQtS9hz0nvVv3VIYg95WMlRmK0EBoJV1LAzo12RimOZ2wb3
         zyAw==
X-Gm-Message-State: AOJu0YyCGDX3U0/FZLrq4Cf756hSAM2aYuEOiLRAP8yQW3mwUDlXGrQO
        SXpTf0AtlhyrgdY1TLaczVp4+Q==
X-Google-Smtp-Source: AGHT+IHy4FKXKcoa5vr1zWRR7h8ldItNotN+bq27os2Gmy1WmTZV3fGNzyOi2gfObdJOXzxcGBLOzA==
X-Received: by 2002:a05:6214:1fd9:b0:67e:b878:8e48 with SMTP id jh25-20020a0562141fd900b0067eb8788e48mr4904522qvb.39.1702311375258;
        Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cf6d1000000b0067a18167533sm3380983qvo.83.2023.12.11.08.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Message-ID: <3f28c1f7-f29c-461f-a90e-58d8e0996cc0@sifive.com>
Date:   Mon, 11 Dec 2023 10:16:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
 <ZXc0rAdi7Vo8nbS8@infradead.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXc0rAdi7Vo8nbS8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 10:11 AM, Christoph Hellwig wrote:
>> +#ifdef __riscv_f
>> +
>> +#define kernel_fpu_begin() \
>> +	static_assert(false, "floating-point code must use a separate translation unit")
>> +#define kernel_fpu_end() kernel_fpu_begin()
>> +
>> +#else
>> +
>> +void kernel_fpu_begin(void);
>> +void kernel_fpu_end(void);
>> +
>> +#endif
> 
> I'll assume this is related to trick that places code in a separate
> translation unit, but I fail to understand it.  Can you add a comment
> explaining it?

Yes, I can add a comment. Here, __riscv_f refers to RISC-V's F extension for
single-precision floating point, which is enabled by CC_FLAGS_FPU.

