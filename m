Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114C37CCAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjJQSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:38:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB090
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:38:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77409065623so352134485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1697567921; x=1698172721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsaRBkXVnZ5gQ0bfD3LH2OWV/lnyvaLOJpA+t9fKpcs=;
        b=FyAGsIscSHJwVwbXBvGZ7IaysOwZJMwMRzHrOhMsbvq+tFHQvTi5zaWdoNxZjvb3br
         eXKTmSA/5VcdOuFb9HvaGl1GFauaoIXl6K6R1ut9Gh2Y3mrG8sQfoKlObRCmiUdJlMuh
         gtGx0BvtL+3YEY+Mwii2RFrAezANHQa2Y60Y5mLLB73q1H8veXugQ1T5wIsLyFi2UPAk
         5T+pKtsCVF0Tryr7R+p8ZYs1PfjE6P5LTBCsmYrOK06cSxTqUm3mkQ6TBoy+wfvaX6HC
         fOt1I+lNqzgUIz/12rtJ6MYLQJKr8F2dTRkiec67+5zXDdPtySuEWOakx5Cb4TbELkhP
         nfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567921; x=1698172721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsaRBkXVnZ5gQ0bfD3LH2OWV/lnyvaLOJpA+t9fKpcs=;
        b=W46OPG6Ho1bjkmzR+cSIPbXhnVLr+yY2CStzOj015jYzApgYQhMBTTTm39CspkI83h
         HVd94hsrXC57yr9KDbk4UYRiQQjsDoO0nPVh3S6AtVsaaHq8cN3V+eXNqIqHa1lStGUk
         iyarU3o2HqZk2UKveiId70HS3lggbzUk097+fWUq9ASHeK/1pMyn12WLwSkYigJxBt6n
         P8NHSfhkZTywd6B6PiP6x2NT37kdILM2TQPOt0hDdmQ3ejD9dogTrXIYxvg9cHgAaRts
         uqHGUneRfE3wpsb4d/TThpbBNQoucMbUVZC8C+kQCPAQOtEZcBg79Mtpn6IcBA8C+nR5
         r3ZA==
X-Gm-Message-State: AOJu0YypOCpOJ0jIm/3Q5H0LtCRkJ2J7LnLVvlyvVd5MUjxLnjgTY/9x
        T04H+tuTUBfOKjxWkN8QvdYr4w==
X-Google-Smtp-Source: AGHT+IEb4loGMCpPOVn6Ab+wN9cQ9sYm3udk2P0fPAOn+o3REaidWVnlpV97HdQcRaGqmi3sZ0ab3A==
X-Received: by 2002:a05:620a:3951:b0:773:c075:a4e7 with SMTP id qs17-20020a05620a395100b00773c075a4e7mr3115161qkn.11.1697567921072;
        Tue, 17 Oct 2023 11:38:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:95cc:ccc5:95bc:7d2c? ([2600:1700:2000:b002:95cc:ccc5:95bc:7d2c])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a408900b007677347e20asm866377qko.129.2023.10.17.11.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:38:40 -0700 (PDT)
Message-ID: <a65fd79f-e0d3-4618-9579-d4a19ba91302@sifive.com>
Date:   Tue, 17 Oct 2023 13:38:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next 3/3] RISC-V: cacheflush: Initialize CBO variables
 on ACPI systems
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-4-sunilvl@ventanamicro.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231016164958.1191529-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-16 11:49 AM, Sunil V L wrote:
> Initialize the CBO variables on ACPI based systems using information in
> RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

