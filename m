Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D27FB9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbjK1MUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjK1MUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:20:14 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59FB95
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:20:20 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3A7942239
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701174017;
        bh=OT/NwsH1EQXh9JcSfkf9fcMEMOIOKJX9g5y0v1tHEp4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=wGxxCfO6l48oWfGram5U4q5jvFu2XPhYHkjJuVZgUNFLTexjlWXc7oi34lOqxDzgS
         kw9OzuX0v6Mnh0H11MXEyOCXHj9xT0ltOXLl6HJ4FdihnWe5pPfvri7m5vvleF0xzA
         1o8a8RK3JAbNHW9kYQ5dMDB6K66ggXHkJg8j54i3c8VdSrFrf8fwmg6LAjUuxaEaaC
         G73O9e0BW0wvDUsdOTNkaz7SjcJTPCT1mUQdb1P1l6TzfierSvje6dPlAL++hfNeFv
         n2MRYMz9qywY0aE8/jX4zHPHrWhTRmdAEZBKm99MnHU3sxfVxJrwp9XJ+4TN+fA29I
         pSJd7BN9LTTGQ==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4236fd10c21so75023201cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701174016; x=1701778816;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT/NwsH1EQXh9JcSfkf9fcMEMOIOKJX9g5y0v1tHEp4=;
        b=r/pvJeeGywUy7aUVmIlYlR9ujbiiFkxQQ6dHo6CmqOzvYu1x8kvl+fX1iCiy5Urg28
         61q/K+8lysrXwARlABZ9h0QWHpSPKCHDtKyTvFrjVHm1fvl6jKa/gqxLzHqw+CipkRXS
         CMAuIfIGmvMz/IBu38kp3aUFMn4/6hw49oUBnehoGKJgikhxqzeSfHe6WmQ7hEyPD9km
         aDK4YnG/neIpiONDjAUe1PF7M/TB/GWrvPA/R/J/FvDef+CinCZ+JxHtj1KrDB+Zrh+1
         uPE1Df9cchKt7TxRPdQ4zM2U5uxkvhtrzroTAKpPHn9V4y6jNzGOo6CdPmmkVvzCbXVm
         n77Q==
X-Gm-Message-State: AOJu0YxQYS6adEbjFCLlSsiqjnMnk72UovftZkf7SZedlKVifG4lj0XC
        42Mt5ITqg6KuR69k5+H3Cp4gvZWbtMZi57xXaK8UA3CEiZZRpgFYFOqfd3S6rUmmYQB2IFXY59y
        +6tHxXqsNxAKteGbsbV8XsLTglopKloKCD0bumRBt0YiIWYse4lBoRN6feA==
X-Received: by 2002:ac8:4907:0:b0:423:d888:39ea with SMTP id e7-20020ac84907000000b00423d88839eamr2065881qtq.46.1701174016639;
        Tue, 28 Nov 2023 04:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX8bkt+j0O9kxUuQrWnAv55U9ri4Y/ATTBeecMJhL7NOkDwIFVgEbHZBWwRkC97Z5i8wlZCnBCN4rS4NVDfkk=
X-Received: by 2002:ac8:4907:0:b0:423:d888:39ea with SMTP id
 e7-20020ac84907000000b00423d88839eamr2065864qtq.46.1701174016427; Tue, 28 Nov
 2023 04:20:16 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 13:20:16 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231126151739.1557369-2-masahiroy@kernel.org>
References: <20231126151739.1557369-1-masahiroy@kernel.org> <20231126151739.1557369-2-masahiroy@kernel.org>
Mime-Version: 1.0
Date:   Tue, 28 Nov 2023 13:20:16 +0100
Message-ID: <CAJM55Z9f7zd8W9hm+XO+cNTRkyH9HDmRqoNoKsfVQe9OB-6NYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: replace <asm-generic/export.h> with <linux/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm-generic/export.h>, which is now a wrapper of
> <linux/export.h>.
>
> Replace #include <asm-generic/export.h> with #include <linux/export.h>.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!
/Emil
