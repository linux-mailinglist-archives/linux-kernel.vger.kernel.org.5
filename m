Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA17D6C79
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbjJYM5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjJYM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:57:07 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB7116;
        Wed, 25 Oct 2023 05:57:04 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b413cc2789so266761b6e.0;
        Wed, 25 Oct 2023 05:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238624; x=1698843424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXkd9CYREbxYom8qIlZV1H5Ayph53CXojJYgpfSQsTw=;
        b=vrxX2PXkT8LPmUYJwTtMZAOHW85b/2vrED+MvJ8RZPLHKZCiQ/S/sV1Cjg/gsaaXoh
         QTb6osh42WwOkVAM+m7X+jVO7VPislGyThYw+5kWNyfSmCoHaohGlRKvLCdRdevvZKXj
         WY9cYO0Vvr/cGC8o24Jmk0ANimye8YU8OD/+TIUxYtjH0ZqlBJFfncyJoTpzW44doEdX
         4le9YYXKN3VslCv6gCirItOlHlTgzEaz8GEhe6d0QIrtMSA4q5qFU5QW1Spd13afYtiy
         7hZSZ+KJQKCA1nHJ6xqCf8K5I8DRTUGezuQPlhfitYUiahA+xSozTUkocnPiyCfHZVj3
         7EGQ==
X-Gm-Message-State: AOJu0YzvG+oEtr6k9tVzQwb57gqIiftUSvpoNeStvOj7/L+edqVLrZuE
        6Iir+KRyKz2XrPGbrbVPRTpuUbvtXBxjwfAh6tuzJOfx
X-Google-Smtp-Source: AGHT+IFa57Vto1+bpGsZj3Sj3ypmLBQMvnjG7z1p5RFQwODE2222n3Z8mQbF79uS7Hlc0CSFdJ/R9suLFz2Epg+GHck=
X-Received: by 2002:a05:6870:818d:b0:1ea:6883:99ff with SMTP id
 k13-20020a056870818d00b001ea688399ffmr16936693oae.5.1698238624011; Wed, 25
 Oct 2023 05:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 14:56:52 +0200
Message-ID: <CAJZ5v0gPhG2VB4p4oXuJ36Qoj-BSEbs1kRyb8jPGVDekk06dJg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Replace acpi_driver with platform_driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:34 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> This patchset is a continuation of efforts from [1] aiming to replace
> acpi_driver with platform_driver. To ease up review effort I'm sending
> miniseries per driver, with a replacement patch + various improvements
> that were noticed by me, or during internal review.
>
> This mini-series takes care of acpi_video driver.
>
> [1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t
>
> Michal Wilczynski (6):
>   ACPI: acpi_video: Remove unnecessary checks
>   ACPI: acpi_video: Use yes_or_no helper instead of ternary operator
>   ACPI: acpi_video: Remove unnecessary driver_data clear
>   ACPI: acpi_video: Replace acpi_driver with platform_driver
>   ACPI: acpi_video: Rename ACPI device instances from device to adev
>   ACPI: acpi_video: Fix holes in acpi_video_bus
>
>  drivers/acpi/acpi_video.c | 101 +++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 55 deletions(-)
>
> --

Because this is not going to get into 6.7 anyway, I'm deferring the
review of it until 6.7-rc1 is out.

Thanks!
