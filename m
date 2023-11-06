Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B47E2A13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjKFQkd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 11:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:40:30 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862FD69;
        Mon,  6 Nov 2023 08:40:27 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-582050ce2d8so786093eaf.0;
        Mon, 06 Nov 2023 08:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288827; x=1699893627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPIV7njENdtTLYGqIiMuh5zgPYOZ2BUnv8BTJaAa4sw=;
        b=sIhW2K17mPvlDBQNhrbocbYUZW6sOj0mpIDW67+S/28GUeaCyGYJOgJTtUMR6L1tsB
         gul1/rZdI8WoQb+Nib9rMP1cW3HzBUMR8C4k2Xg6yIHa16ABqpXNtLIUkde2A23JYVUR
         gIY0F/Ny9rUrkbal4BoaKDd1F6MOyHFxIw/l0+OkSDMoaWNyXu9nrZ8tyovkpjAVjsG3
         N0EjmOHLY73OoN5ngcU4T9ewPPQF5ZEdMB0xmiCyBhrjKObAnI42i25xPEAE6EHag4d1
         QCuoTC4DXbfgwcYoy1LS9/8MiDad4HinKm5GpS8mNayyJi1CW7F7LD2V2fIR0wVikqu/
         5s0Q==
X-Gm-Message-State: AOJu0YxBAt31RHoXR7qQG/vx69lMSR5OzDUjSIe74BA9tSAwp6qoEQhy
        Q/RVJY4teL76duaE9dD8tkLixFJ0D8eaz7ne6CU=
X-Google-Smtp-Source: AGHT+IEyfwHzUPeJZnVzXL+Ns9NOSQHsSPT6LPvODBhLKEmp64eJKWbGIKzyB43ZlkY1vH3xRTBmtWmKYXZdXt6Aq14=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr28730645oov.0.1699288827078; Mon, 06
 Nov 2023 08:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20231002195932.2501674-1-avadhut.naik@amd.com> <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
In-Reply-To: <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 17:40:16 +0100
Message-ID: <CAJZ5v0gM5owYgRxzjy_zFH1R8Fuk53W=LDhd33mB2U7j5=Ra0Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
To:     Avadhut Naik <avadnaik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        Avadhut Naik <avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 5:37 PM Avadhut Naik <avadnaik@amd.com> wrote:
>
> Hi,
>
> Any comments on this patch?

Please resend it with CCs to the designated reviewers for APEI, as per
MAINTAINERS.

Thanks!
