Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29F7F2E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjKUNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjKUNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:32:25 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83479D6F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:32:21 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5ca9114e0e2so20578727b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700573540; x=1701178340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhGZv1Nv08MvRW2DJYjs+d3sOa+HumQD0w2cfdSjlYU=;
        b=o1gYLyN7nepNx9mjc188FdMxaA/2ONPzvIHKI5fpxkddLVUjPTjn65ZJGM+RNe+0rV
         AgceHBBzOy0c3EHEDVDv3Dbf+2iX5thOtT9KQZK6DHP3x4unuWL4ge+czeQcqyLq9ts3
         HGOBjdF76wVvKqR0oJYw96hcFG2CHTQwGRUcPybljtcl+UBwnij3jXSTq2YPR3kuyEnM
         drqRv7WrNNIfdAIoCIbQEq4/f5GO7ihEtZsQ4fqI0go1VsGG4XgDhFfHIHwLBg+kuifV
         DbPzikbC7Rz4oHPMjM6A9p1+u7t/ZmRziYNp2roP+I8m8lMvPbN65pvZplMKC8g74n6Z
         3b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573540; x=1701178340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhGZv1Nv08MvRW2DJYjs+d3sOa+HumQD0w2cfdSjlYU=;
        b=RfBQmzvUCjL/Px/NGkZ9qzMz6Wp/sG+/ejw674znNOO5JKQ16oNg05934oMRUfSzd1
         dCE1pdHw6fiV6uQ6NclL6KlDtLqVErvx3F22ToXR0omqvV4gKLM3CWMkGPXCtPhzbsIz
         7ghrVGoNAJDmpvc5BSKWxdZVQqQADlpj+aoTBDuHmNyMhWtWK662vnz6FQ5zDWae47As
         yjXRRPHsUdSVOlFz1/DBnNmZOcvwllzh/wXujfJPdphNNHkvh/2IoU/W/fWd0N8LA6V1
         5451kUwKF1wL/k5rgJZQYFDjTVhpVl/kom0igwqpU+x7lmIzXsP3fGRLkdW+I4cM6Gbw
         wyNw==
X-Gm-Message-State: AOJu0YyLPuNTZn1AIkfCMIXBupV6LInLt4oC+ot/ePQda1EnmX4MgH0g
        YvINLrxSGUk377Md2YpeoDedexlgf7/Kh6brGCAurw==
X-Google-Smtp-Source: AGHT+IG5fMKPSUUlBQk/9z9KQDvVshTXZ/yb2JO2VCDadLEWCNWZCTpRysGdod7EeVu9BQ2Pr8mBjhdK5xSfgbEhxcM=
X-Received: by 2002:a81:b606:0:b0:5c9:70b9:84d5 with SMTP id
 u6-20020a81b606000000b005c970b984d5mr8331718ywh.8.1700573540642; Tue, 21 Nov
 2023 05:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
 <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com> <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
 <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
In-Reply-To: <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Nov 2023 14:32:08 +0100
Message-ID: <CACRpkdbz=a7yoJdBOrgJXth53d=F7+eQCu7KofUW8s1rBY=Veg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Edwards <cfsworks@gmail.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 5:53=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:

> However, if I move fw_table.h in linux/acpi.h below include of asm/acpi.h=
, then we
> can build successfully w/o including acpi/acpi.h in fw_table.h.

This looks reasonable to me, can you send a formal patch so I can test?

Yours,
Linus Walleij
