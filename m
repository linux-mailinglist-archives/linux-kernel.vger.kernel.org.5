Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22E57FC1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbjK1PG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbjK1PG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:06:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886671B9;
        Tue, 28 Nov 2023 07:07:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c48fad2f6dso742876b3a.0;
        Tue, 28 Nov 2023 07:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701184023; x=1701788823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmP5nlMJcy2AQEk5Ah3+PGHSBgMAR1YOowcqoZwBuwE=;
        b=m6okz2KE6YXTDbBoZAip0mRa8uTKiU7z7htedxGL8HTp6sBzZzBiKwuGCqFk8JcECY
         AadHMMyjWPblID1F75qs6MakpZSV72RfykpoozVMCR2exguDoOVsdVz340FlV85psSJf
         eutxMeB2WvwHRiDwUg5dor9fGLB3ovSpH4wL6ijVBHtiOE/9Olk0vn2ITC7ML7CID80O
         BMHFewWiGJBSU1cQKJ/kes+Q72wrxq5XDb4864gxEDt5PdILFil2VOzxon/27Ih7+tz5
         0/2kq+GFvUqo0F8XSoaIjEmSeMnH8ebqYO7eBo/FFwmumpbAs3yV380J2ZMk/JggDanV
         ptQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184023; x=1701788823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmP5nlMJcy2AQEk5Ah3+PGHSBgMAR1YOowcqoZwBuwE=;
        b=N77hAzRo3IUUZKuOk9Oxi3nvIaG4eNOQ8DdLXAaDd4OGUBzf6kPtskYeuSNrQXWKSm
         ur8WK9Gxo12bWYglWrH1ZFyllCfXbelbEl8KQ2UGdmCXFZhOmjA0ckG3dOtGVo9VofLn
         9wK/TROLy6L5Cypi3bWcy36qhf9to23fqCI+vPAv3Nc2lOH8SVjkseKPDo/ZUEPVkf3H
         p7req3CsAlRMDqcO0k8lu10LRskJNVhZRTeVbMNYjM4lOOEoMCHUiMP0jdPYshF9eNw/
         x941lwGe2+sw512J1gayUYVGPTVQn2uTY3YPuxnS3l2Rq6PvI5XOngK32M8WRiChm/u6
         MVRw==
X-Gm-Message-State: AOJu0Yx7ShT2Dfqr4DnzW7RzJInj3XpqYSiFEpP9I+Y+ni7Ey5iRQvv0
        mgrz+8PVIJDcDn+aeg0Amm8=
X-Google-Smtp-Source: AGHT+IGA+1IkSAt8R/E4ZUt5UcvOyQpDGeFEoqpFKgIJ/W59CS/sIXqkCq/HUKYZ1/n7wBZ/XetOlw==
X-Received: by 2002:a05:6a20:7f8c:b0:18a:f711:7c12 with SMTP id d12-20020a056a207f8c00b0018af7117c12mr17560536pzj.4.1701184022957;
        Tue, 28 Nov 2023 07:07:02 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b006c1221bc58bsm9015296pfh.115.2023.11.28.07.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 07:07:02 -0800 (PST)
Message-ID: <83e432ec-b31c-4f90-a87c-8db8983a9d5e@gmail.com>
Date:   Tue, 28 Nov 2023 20:36:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] driver : edac : Fix warning using plain integer as
 NULL
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CY8PR11MB7134D203710F24755B7651E889BCA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20231128141703.614605-1-singhabhinav9051571833@gmail.com>
 <20231128144320.GCZWX8iMRIIX6qDyVO@fat_crate.local>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231128144320.GCZWX8iMRIIX6qDyVO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 20:13, Borislav Petkov wrote:
> On Tue, Nov 28, 2023 at 07:47:03PM +0530, Abhinav Singh wrote:
>> Sparse static analysis tools generate a warning with this message
>> "Using plain integer as NULL pointer". In this case this warning is
>> being shown because we are trying to initialize  pointer to NULL using
>> integer value 0.
> 
> Applied after massaging, thanks.
> 
Thanks a lot for reviewing and merging the patch maintainers.

Thank You,
Abhinav Singh
