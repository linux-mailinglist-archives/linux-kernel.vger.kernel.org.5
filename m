Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA17D718C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjJYQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJYQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:16:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3C123;
        Wed, 25 Oct 2023 09:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698250597; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gLCa3+5gsMBsLqkGJnPgYTo9DQhiS7UtiJkO2w3onvNgyUgu3c+UJZQ3WpkkqmFgio
    +Ct7THBgNSn3VDUuUpcVeneLcWyhb+DmA8n/s+Ay/MVc4WkK5zHCczdfdiX5dd2A7EiP
    XBpQgv0+4YgqIdHNn/7LSgZ3EU2Ffx25IPwgRAhSS9Gf3i5C1fYxiOTpKWuXuJoLm3Xd
    0OiajtKpow2ysGTWHJzGqMqrOOj68JHrk30al6dAsT1fhySbcqV8beUvjX/iLHoQbxg4
    0zktsFkusnzeGNJ0hpSpU6YRvBXvpWpHyiWcTL0ByIPljwLpY6k0Tz8OXYbqjTV7F/ac
    9+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698250597;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YZSlPhYXy89WILkt7DEnTutEx64M5HjQplPlI7eKTlA=;
    b=oUTBczkl/Z7j569z4b/Z0RHpvRxywVU19DkVeadQv7SUhAjCYIzcEDztpPpqx619rj
    yJAPo4V1jNVgAxI2dYGR5wKMJx18hVOhQ9nNLvx/ebS8sB5JTYYwhGHsemaFXKJYhPKk
    qdnP/gmh8fmV14DjMN3wxGAJWFee15KFyk3rI2XqwXVL0sZaI4tCImU0NXFstGj3RvdD
    gSmEADSfpAagbNt+7hoOTI98IIs3mVyLYndP+XNTrGKI/1201AMGiJo58CNUI7aveXLq
    Hc4kmTwONS6a9GjShx7T9trWf/AYVeDSVn+rUV2qCDp4sSWcX1KaGD3ZocT3s+RWqZvl
    RjOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698250597;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YZSlPhYXy89WILkt7DEnTutEx64M5HjQplPlI7eKTlA=;
    b=ni1H2Tg09k9Yx2+vqmEr50MShI56zElzEEX4DfMGrezSaDxXlHpj25BYnJIJsd4yE7
    4ga3lJ6nIEdJS4dPlPT0Hgs/s0ODvGie2pk+ASEkX937nlFva8nQXrsAwm7jEqmyyBJL
    kRZZasD8X5oCIe+hcBfRW/3Xi4VoAtI6WEVfUBEKK7mIm4CMSdizoueO7Y9wmzuSRkmi
    xGLGT13I4qIHtpNVtVMBPhIXVCJzHcDOiLWQIMDn4AxAndeG99cssnrtj6iWPkeRc1ga
    353YrVKMbtoPXOAaZTOZ/DSfFcq1qYybF3Zl8YDZkJai/UUO615QWl42I+gxtQehESBL
    DUsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698250597;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YZSlPhYXy89WILkt7DEnTutEx64M5HjQplPlI7eKTlA=;
    b=FYXRoN4r3jY0yJQhpSLkzm7eQDw7/04cE0FHFwuJBobq+KjWBXissAbCSoLxt5ipbg
    fmvq8AEAo4lGvomcXvDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2z9PGGb0iQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Oct 2023 18:16:37 +0200 (CEST)
Date:   Wed, 25 Oct 2023 18:16:23 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <ZTk_M0JFdAg7FR7E@gerhold.net>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
 <20231025152431.bhdv772dwbufocck@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025152431.bhdv772dwbufocck@vireshk-i7>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:54:31PM +0530, Viresh Kumar wrote:
> On 25-10-23, 15:47, Stephan Gerhold wrote:
> > FWIW I'm hitting this WARNing when trying to set up the parent domain
> > setup for CPR->RPMPD(MX) on MSM8916 that I discussed with Uffe recently
> > [1]. I know, me and all my weird OPP setups. :'D
> > 
> > Basically, I have cpufreq voting for performance states of the CPR genpd
> > (via required-opps). CPR is supposed to have <&rpmpd MSM8916_VDDMX_AO>
> > as parent genpd and translates to the parent performance state using the
> > "required-opps" in the *CPR* OPP table:
> > 
> > 	cpr: power-controller@b018000 {
> > 		compatible = "qcom,msm8916-cpr", "qcom,cpr";
> > 		reg = <0x0b018000 0x1000>;
> > 		/* ... */
> > 		#power-domain-cells = <0>;
> > 		operating-points-v2 = <&cpr_opp_table>;
> > 		/* Supposed to be parent domain, not consumer */
> > 		power-domains = <&rpmpd MSM8916_VDDMX_AO>;
> > 
> > 		cpr_opp_table: opp-table {
> > 			compatible = "operating-points-v2-qcom-level";
> > 
> > 			cpr_opp1: opp1 {
> > 				opp-level = <1>;
> > 				qcom,opp-fuse-level = <1>;
> > 				required-opps = <&rpmpd_opp_svs_soc>;
> > 			};
> > 			cpr_opp2: opp2 {
> > 				opp-level = <2>;
> > 				qcom,opp-fuse-level = <2>;
> > 				required-opps = <&rpmpd_opp_nom>;
> > 			};
> > 			cpr_opp3: opp3 {
> > 				opp-level = <3>;
> > 				qcom,opp-fuse-level = <3>;
> > 				required-opps = <&rpmpd_opp_super_turbo>;
> > 			};
> > 		};
> > 	};
> 
> I have forgotten a bit about this usecase. How exactly does the
> configurations work currently for this ? I mean genpd core must be
> setting the vote finally for only one of them or something else ?
> 

I'm not sure if I understand your question correctly. Basically, setting
<&rpmpd MSM8916_VDDMX_AO> as "parent genpd" of <&cpr> is supposed to
describe that there is a direct relationship between the performance
states of CPR and VDDMX. When changing the CPR performance state, VDDMX
should also be adjusted accordingly.

This is implemented in the genpd core in _genpd_set_performance_state().
It loops over the parent genpds, and re-evaluates the performance states
of each of them. Translation happens using genpd_xlate_performance_state()
which is just a direct call to dev_pm_opp_xlate_performance_state().
This will look up the required-opps from the OPP table above. However,
the genpd core calls ->set_performance_state() on the parent genpd
directly, so dev_pm_opp_set_opp() isn't involved in this case.

Overall the call sequence for a CPUfreq switch will look something like:

 - cpu0: dev_pm_opp_set_rate(998.4 MHz)
  - cpu0: _set_required_opps(opp-998400000)
   - genpd:1:cpu0: dev_pm_opp_set_opp(&cpr_opp3)
    - genpd:1:cpu0: _set_opp_level(&cpr_opp3)
     - cpr: _genpd_set_performance_state(3)

      # genpd: translate & adjust parent performance states
      - cpr: genpd_xlate_performance_state(parent=VDDMX_AO)
             => &rpmpd_opp_super_turbo = 6
       - VDDMX_AO: _genpd_set_performance_state(6)
        - rpmpd: ->set_performance_state(VDDMX_AO, 6)

      # genpd: change actual performance state
      - cpr: ->set_performance_state(cpr, 3)

Before the discussion with Uffe I did not describe this relationship
between CPR<->VDDMX as parent-child, I just had them as two separate
power domains in the CPU OPP table. That worked fine too but Uffe
suggested the parent-child representation might be better.
   
Does that help or were you looking for something else? :D

Thanks,
Stephan
