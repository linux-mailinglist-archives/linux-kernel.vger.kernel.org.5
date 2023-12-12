Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1C80FB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377498AbjLLXzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjLLXzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:55:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A892;
        Tue, 12 Dec 2023 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kvcZNEP58ugqv20Pm1mONv8BuiUHlOHp24bA+swL/RE=; b=CnIU0dTwkYZLeCDDAl7dUkETmw
        mXDyZZWZ0erdOyMV6hr212MWbfRA8D/Qk7N02Vf6D96nE0J3QoKq/qsrwU967k+WgcKliYYmsG0ZV
        o7h6bOsx1UNX+Vf98XwJv9VYPg9P6YpbgxRvkokaCgysiGlOWrCejBj2QyUrV/nCxcKCWV5KZArBh
        i8u4SkGvNIu3Hv4Qok7wd8zUuh0j0RCB1xU30xinXmmkZPv/ugtQxqqYArOgowwgJu70W8GHmxcOh
        PnaJlj8kyd3Fmix9b5MmMOy1ajiK8vYij+CLHyA8Kkl9o06R4Hfd3rjwyXm3pGZ2XwJ8mq8w7Lh6D
        SHLgpM7w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDCbG-00D5YC-1v;
        Tue, 12 Dec 2023 23:55:42 +0000
Message-ID: <fd5e2d54-1309-48a9-8458-ee5f2ebb039e@infradead.org>
Date:   Tue, 12 Dec 2023 15:55:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] parse_phat: Add support for ACPI PHAT Table parsing
Content-Language: en-US
To:     Avadhut Naik <avadhut.naik@amd.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        avadnaik@amd.com
References: <20231212195219.2348858-1-avadhut.naik@amd.com>
 <20231212195219.2348858-2-avadhut.naik@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231212195219.2348858-2-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/12/23 11:52, Avadhut Naik wrote:
> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
> an extensible set of platform health-related telemetry. The telemetry is
> exposed through Firmware Version and Firmware Health Data Records which
> provide version data and health-related information of their associated
> components respectively.
> 
> Additionally, the platform also provides Reset Reason Health Record
> in the table highlighting the cause of the last system reset in case
> of expected and unexpected events. Vendor-specific data capturing the
> underlying state of the system during reset can also be optionally
> provided through the record.[1]
> 
> Introduce support for parsing, decoding, and logging the PHAT table, if
> supported by the system. By default, the table will be logged to stdout.
> The same, however, can be changed through the "-o" command line parameter.
> Additionally, the tool also provides a hexdump of the entire table, if
> needed, through the "-x" parameter.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  Makefile     |  12 ++
>  parse_phat.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 528 insertions(+)
>  create mode 100644 Makefile
>  create mode 100644 parse_phat.c
> 

Does acpidump not parse the PHAT table?
Could it?  Should it?


thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
