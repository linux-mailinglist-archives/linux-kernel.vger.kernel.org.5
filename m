Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916B78DEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbjH3T0p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Aug 2023 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbjH3OTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:19:36 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A8122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:19:32 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 635EC20035;
        Wed, 30 Aug 2023 16:19:29 +0200 (CEST)
Date:   Wed, 30 Aug 2023 16:19:23 +0200
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
Message-Id: <BSJ70S.HFFPUN9486BN2@somainline.org>
In-Reply-To: <CAPKp9ubXJbLQ_jOt3sp7Y8KXKyp42bzjHqbaa19LSqGMxE2yPg@mail.gmail.com>
References: <20230830-smccc_export-v1-1-6ecc7661bc94@somainline.org>
        <CAPKp9ubXJbLQ_jOt3sp7Y8KXKyp42bzjHqbaa19LSqGMxE2yPg@mail.gmail.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches using this are still WIP but the basic point is that H616 
has 2 die revisions (And those have
couple of other versions themselves) that require different uV and some 
frequencies are blacklisted on those
versions.

The driver is using these functions to read the revision (Not the 
version. It just looked like the logical
thing to export both and Andre confirmed. We can ofc drop the version 
symbol export if need be) and reads
trough the OPP table and selects the supported frequencies and uV for 
the chip its running on :)

I will try to get the cpufreq patches in order in the upcoming days and 
I will Cc you in those as well +
post a link to them in this thread :)

Cheers,
Martin

On Wed, Aug 30 2023 at 03:05:09 PM +01:00:00, Sudeep Holla 
<sudeep.holla@arm.com> wrote:
> 
> 
> On Wed, Aug 30, 2023 at 2:24 PM Martin Botka 
> <martin.botka@somainline.org> wrote:
>> arm_smccc_get_soc_id_version and arm_smccc_get_soc_id_revision
>>  need to be exported so they can be used by modules.
>>  Currently sun50i cpu freq driver is planning to use these functions.
> 
> I am not against exporting these but please post along with the 
> patches using these
> exported symbols so that no one complains about you exporting the 
> symbols mentioning
> some patches that may or may not appear in the future.
> 
> --
> Regards,
> Sudeep


