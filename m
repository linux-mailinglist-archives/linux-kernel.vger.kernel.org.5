Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1A800B12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjLAMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378844AbjLAMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:37:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC4D13E;
        Fri,  1 Dec 2023 04:37:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747291007;
        Fri,  1 Dec 2023 04:38:24 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87A293F5A1;
        Fri,  1 Dec 2023 04:37:35 -0800 (PST)
Date:   Fri, 1 Dec 2023 12:35:34 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V2 2/7] coresight: funnel: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <20231201123534.fqtknbabvl3bdhq7@bogus>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201062053.1268492-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:50:48AM +0530, Anshuman Khandual wrote:
> Add support for the dynamic funnel device in the platform driver, which can
> then be used on ACPI based platforms. This change would allow runtime power
> management for ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> funnels.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only

-- 
Regards,
Sudeep
