Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37878DDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbjH3Swd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245627AbjH3Ppd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:45:33 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC55132
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:45:30 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5A346203A7;
        Wed, 30 Aug 2023 17:45:27 +0200 (CEST)
Date:   Wed, 30 Aug 2023 17:45:21 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH] firmware: smccc: Export both soc_id functions
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>
Message-Id: <LRN70S.BVS224FBSYMM3@somainline.org>
In-Reply-To: <20230830154312.zferm3it7mj4nwsy@bogus>
References: <20230830-smccc_export-v1-1-6ecc7661bc94@somainline.org>
        <CAPKp9ubXJbLQ_jOt3sp7Y8KXKyp42bzjHqbaa19LSqGMxE2yPg@mail.gmail.com>
        <BSJ70S.HFFPUN9486BN2@somainline.org>
        <20230830154312.zferm3it7mj4nwsy@bogus>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.

Cheers,
Martin

On Wed, Aug 30 2023 at 04:43:12 PM +01:00:00, Sudeep Holla 
<sudeep.holla@arm.com> wrote:
> On Wed, Aug 30, 2023 at 04:19:23PM +0200, Martin Botka wrote:
>>  The patches using this are still WIP but the basic point is that 
>> H616 has 2
>>  die revisions (And those have
>>  couple of other versions themselves) that require different uV and 
>> some
>>  frequencies are blacklisted on those
>>  versions.
>> 
>>  The driver is using these functions to read the revision (Not the 
>> version.
>>  It just looked like the logical
>>  thing to export both and Andre confirmed. We can ofc drop the 
>> version symbol
>>  export if need be) and reads
>>  trough the OPP table and selects the supported frequencies and uV 
>> for the
>>  chip its running on :)
>> 
>>  I will try to get the cpufreq patches in order in the upcoming days 
>> and I
>>  will Cc you in those as well +
>>  post a link to them in this thread :)
>> 
> 
> For simplicity, just make this patch part of the series that adds 
> cpufreq
> support on this platform/soc. Cross referencing won't give any more 
> confidence
> that the user is also getting merged at the same time as this patch.
> 
> --
> Regards,
> Sudeep


