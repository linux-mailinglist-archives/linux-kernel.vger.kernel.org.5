Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523E78C668
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjH2NqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjH2Np1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:45:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1C7E67
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:45:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bed2c786eso3033465b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693316652; x=1693921452;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yL2RRP3KQ0GKocF3XTU0hxy2zxqD7zAKBRh8yTybidM=;
        b=RbWQSsKQqsizqte4IBQ4fp0ZQgNU2YQF93yXY0m7HHpwXkBFSWNrs1rp0iSYr3bTox
         sj0zvVvYpiABe7MmHYH3keB5l+PyT1OXriD4e8B9HT1mJfqTmxIXTE+SJ+4pVdJ1BM/w
         N1lhxmpUA9gXOpca8tr/ODJ4AeG6KzIdWOAarTpYcZGRW8uB62MGQVEeXJ60i7UeaFRN
         onMxc30siGVLn4S3XsWrzvIObP1pDtMyVH0NwRE0bJJpT/48u8VrF9TpUm+BCg/YPzlB
         ne+5PMlVYvudRAU3JocQZBRFhqJFTzwkc547j23+VpEK1AmN32aoicCb6E6sSwAwt7b4
         Pw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316652; x=1693921452;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL2RRP3KQ0GKocF3XTU0hxy2zxqD7zAKBRh8yTybidM=;
        b=N3Mmp/aSghztXw0uH/9XQMbYs24dZ6OlK6QvOwJUJ24+skvsc5YHcIPFjmjoA6k+mb
         NhoAw/ykx4yC67VuJXVgLmt17Vd2Z8J1ER5n7QJ7Azr8H/zVJI8Dd9JgudDPGNqW5IJ9
         fvnkZ2GQ8lsS3302lthjUU38q1f3c2TKFDnMIug30oQscQE3RBEo/ssWhPSIxwlEeQyE
         KoqOM3eWEbY91hxsd4XVxB18szVOIIm3NstaEn5Gi8SmbqgkeHdT4xRTQSDlYcnl592S
         QeM3n+Ekfzmw4raFma1gSZWDBxEXaJcz87lzE7rvqKMub5L1j/4J0D1NToAsAld8yFys
         B96A==
X-Gm-Message-State: AOJu0Yy3xOp/8K4a8XoNxi1VCiaLiSZY51SgCYmfiY2quMl62TvaSK63
        We7WrxhEki21oPjZi3yOSwM=
X-Google-Smtp-Source: AGHT+IFTwvR0E1TvRT5nE8YgkhHR3qk0r0Bo5hiz/rgnl+WIV3HpzKT0a8VWlutgRRyt/gSgrpJ/QQ==
X-Received: by 2002:a05:6a21:7746:b0:14c:d5c7:381b with SMTP id bc6-20020a056a21774600b0014cd5c7381bmr6812083pzc.36.1693316652123;
        Tue, 29 Aug 2023 06:44:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a00270600b0064378c52398sm8453567pfv.25.2023.08.29.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 06:44:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 06:44:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Message-ID: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
> introduced a workaround for MWAIT for a specific x86 system.
> 
> Move the code outside of acpi_processor.c to acpi/x86/ directory for
> consistency and rename the functions associated with it, so their names
> start with "acpi_proc_quirk_" to make the goal obvious.
> 
> No intentional functional impact.
> 

Except for:

ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'

which breaks all ia64 builds.

Time to retire that architecture yet ? No one but me seems to even
build test it.

Guenter
