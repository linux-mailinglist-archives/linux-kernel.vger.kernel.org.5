Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CCB7774CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjHJJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjHJJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E452C1AB;
        Thu, 10 Aug 2023 02:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669E5655E6;
        Thu, 10 Aug 2023 09:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A65AC433C7;
        Thu, 10 Aug 2023 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691660512;
        bh=p2nLn3yquTs0SCyO0vU3BgZ6hHe2rp6uBgQbpbuZDnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeJKsKWAQqx0KbDgbO9MTUNKaZLkG3yBnXwWYlaqIc+5mKlHTcXAlCUW8QF66jdYX
         RVBBR7fmX00hRniDyy4rbGRQCYRQHymmY9itjiwkkTz6G4bndjlcoD2Nj5Are1+BAE
         6zgzfRCIjMP2cDeqTKoAP2dwMkaoRxsDlMc2syFMRczBNPcaLRXCfXfJyOZOaKXCcc
         vg6FJeAEwMe6dN9JIidX8RjwMdWb9GehSnXd59dAZcTpOp6RSLvDsK5gsH0KBab3E1
         dR8F2vxqC8FA+6spgsMGfQbOAind2ThGQdcPcOj9qSmTudWQKv2AVnRhs/XSpKc0c+
         X7roMlUrVBIag==
Date:   Thu, 10 Aug 2023 10:41:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 - RESEND 01/10] drivers: perf: arm_pmu: Add new
 sched_task() callback
Message-ID: <20230810094146.GB5365@willie-the-truck>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-2-anshuman.khandual@arm.com>
 <0ed54ef6-e502-7c33-6e3f-08de76786245@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed54ef6-e502-7c33-6e3f-08de76786245@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:35:42AM +0530, Anshuman Khandual wrote:
> I am just wondering - would it be possible for you to take this pre-requisite
> patch stand alone for the upcoming merge window. This has been acked by Mark
> earlier. Besides, I am also working on your other suggestions on the series,
> and will respond soon. Thank you.

I can if it helps in some way, but I'm not seeing how it does. Can't you
just carry this along with the BRBE changes that use it? How does it benefit
anybody on its own?

Will
