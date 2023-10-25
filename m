Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D707D6E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJYNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJYNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:49:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C6182;
        Wed, 25 Oct 2023 06:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698241682; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b0DkYwNGn2/WgJ2Xnma4yac8xHmqGpcodphh39KzfhzYLjotLSpIZn7fRwubc4X08m
    egLXXDbZbGpPVHcLAtw2n6JqlRkwT489o6y2gMXc6ZFRaQ+CqD3a8UMybdwEMyGm1esS
    cwAeMcJSAr7Khpi+7Y40ULdG4TytN04z6YFmOV4gu3xICCGQMeUdrbrMwkGs4+SuS7th
    A+B7omGO4AbvZVQxkxTHW7N6GhlJhXAq8Xe9iHuHGjxs1qjIyVcBqYzB0X/4uvHFf7xA
    mE9+7lR+lfl9WyqcjX+ANsPk6umlX4yflBMhOaTeODCbNKhf5lqSGQxIgsrhVgJsseqL
    wIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698241682;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=jI1zYq/CQ5plcniFgmEHVhm/A/UqAMZIxhq+x3h/ul4=;
    b=ikU7/4wR5m9FOCGbUI89bnnHff8ywEWqTVQa3rY1DR++yHVls/gQsBUUxFj3AH55oo
    44drb+pI2yOB0w4CEQQ2L4TOOjE2lFIUTUHC6lSA7yiG/iMelcNjLmXT3Mb96yjtEXAu
    xvJmrDhzQrgWEjCFWzlwVaBq5YkKUzUwMnPFU/eVhb5eWn0Tz7geHciIiKNCPIftSpcX
    H1IiETYIrkUDXIOx2R/MIjOk+L7u7uDc/N0d+85aR+/heaUdI6hXcjzR+zV0wkyXJke0
    2IyXCjq3FY9oncvEVrS1Le4qMQMLvsbh/bLY3w/tJMMT4pPUT6ZGTbG1vt+TLyJ2kmc5
    7yzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698241682;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=jI1zYq/CQ5plcniFgmEHVhm/A/UqAMZIxhq+x3h/ul4=;
    b=G5Pq1aXk24cduZubQu+gODP2H782TyCA9F+eHOUWjes6U9opECj8qfG7id8Y6p8K9u
    xzxlVuEy36WqKTYzTXwK5mXRfhakABg7Htt6mktwhTkiXxJKWeeg8ipsWNw2EBQ+W4VU
    ElnY3eRKrXoY5e0T9P77IeIs139w1H35ZAI+hh2CREkv9k8tm6CT7VkIYcpblaPq9/hF
    O21H0b7u78QU5jQHFT/J5pNh24Bxw4OMXSJHpncnfjWfdSABBTJLoKtX5nW05TCD8eQz
    gPAAW3ayqX5sHo1q65XrH3bRHSRfUgGk+WndZuklaqhUlFYGWY1MLfnH3MQEQ74ohbDI
    JvhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698241682;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=jI1zYq/CQ5plcniFgmEHVhm/A/UqAMZIxhq+x3h/ul4=;
    b=H4iAlsJAO/4rMD2txW3MlpjSCEzXEHxCLlr7/grQx39fHIkCfzloBG12n92q4FAH2o
    C7oPdPXays2X2EpTSjDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2z9PDm20Go
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Oct 2023 15:48:02 +0200 (CEST)
Date:   Wed, 25 Oct 2023 15:47:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <ZTkciw5AwufxQYnB@gerhold.net>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:40:26PM +0200, Ulf Hansson wrote:
> On Wed, 25 Oct 2023 at 08:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 19-10-23, 13:16, Ulf Hansson wrote:
> > > On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > +static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
> > > >                                struct opp_table *required_table, int index)
> > > >  {
> > > >         struct device_node *np;
> > > > @@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
> > > >                 return -ENODEV;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * There are two genpd (as required-opp) cases that we need to handle,
> > > > +        * devices with a single genpd and ones with multiple genpds.
> > > > +        *
> > > > +        * The single genpd case requires special handling as we need to use the
> > > > +        * same `dev` structure (instead of a virtual one provided by genpd
> > > > +        * core) for setting the performance state. Lets treat this as a case
> > > > +        * where the OPP's level is directly available without required genpd
> > > > +        * link in the DT.
> > > > +        *
> > > > +        * Just update the `level` with the right value, which
> > > > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > > > +        */
> > > > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > > > +           !opp_table->genpd_virt_devs) {
> > > > +               if (!WARN_ON(opp->level))
> > >
> > > Hmm. Doesn't this introduce an unnecessary limitation?
> > >
> > > An opp node that has a required-opps phande, may have "opp-hz",
> > > "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> > > used too?
> >
> > Coming back to this, why would we ever want a device to have "opp-level" and
> > "required-opp" (set to genpd's table) ? That would mean we will call:
> >
> > dev_pm_domain_set_performance_state() twice to set different level values.
> 
> Yes - and that would be weird, especially since the PM domain (genpd)
> is already managing the aggregation and propagation to parent domains.
> 

FWIW I'm hitting this WARNing when trying to set up the parent domain
setup for CPR->RPMPD(MX) on MSM8916 that I discussed with Uffe recently
[1]. I know, me and all my weird OPP setups. :'D

Basically, I have cpufreq voting for performance states of the CPR genpd
(via required-opps). CPR is supposed to have <&rpmpd MSM8916_VDDMX_AO>
as parent genpd and translates to the parent performance state using the
"required-opps" in the *CPR* OPP table:

	cpr: power-controller@b018000 {
		compatible = "qcom,msm8916-cpr", "qcom,cpr";
		reg = <0x0b018000 0x1000>;
		/* ... */
		#power-domain-cells = <0>;
		operating-points-v2 = <&cpr_opp_table>;
		/* Supposed to be parent domain, not consumer */
		power-domains = <&rpmpd MSM8916_VDDMX_AO>;

		cpr_opp_table: opp-table {
			compatible = "operating-points-v2-qcom-level";

			cpr_opp1: opp1 {
				opp-level = <1>;
				qcom,opp-fuse-level = <1>;
				required-opps = <&rpmpd_opp_svs_soc>;
			};
			cpr_opp2: opp2 {
				opp-level = <2>;
				qcom,opp-fuse-level = <2>;
				required-opps = <&rpmpd_opp_nom>;
			};
			cpr_opp3: opp3 {
				opp-level = <3>;
				qcom,opp-fuse-level = <3>;
				required-opps = <&rpmpd_opp_super_turbo>;
			};
		};
	};

There are two problems with this:

 1. (Unrelated to $subject patch)
    Since there is only a single entry in "power-domains", the genpd
    core code automatically attaches the CPR platform device as consumer
    of the VDDMX_AO power domain. I don't want this, I want it to become
    child of the VDDMX_AO genpd.

    I added some hacky code to workaround this. One option that works is
    to add a second dummy entry to "power-domains", which will prevent
    the genpd core from attaching the power domain:

    	power-domains = <&rpmpd MSM8916_VDDMX_AO>, <0>;

    The other option is detaching the power domain again in probe(),
    after setting it up as parent domain:

	struct of_phandle_args parent, child;

	child.np = dev->of_node;
	child.args_count = 0;

	of_parse_phandle_with_args(dev->of_node, "power-domains",
 			           "#power-domain-cells", 0, &parent));
	of_genpd_add_subdomain(&parent, &child);

	/* Detach power domain since it's managed via the subdomain */
	dev_pm_domain_detach(dev, false);

    Is there a cleaner way to handle this? Mainly a question for Uffe.

 2. The OPP WARNing triggers with both variants because it just checks
    if "required-opps" has a single entry. I guess we need extra checks
    to exclude the "parent genpd" case compared to the "OPP" case.

	[    1.116244] WARNING: CPU: 2 PID: 36 at drivers/opp/of.c:331 _link_required_opps+0x180/0x1cc
	[    1.125897] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
	[    1.146887] pc : _link_required_opps+0x180/0x1cc
	[    1.146902] lr : _link_required_opps+0xdc/0x1cc
	[    1.276408] Call trace:
	[    1.283519]  _link_required_opps+0x180/0x1cc
	[    1.285779]  _of_add_table_indexed+0x61c/0xd40
	[    1.290292]  dev_pm_opp_of_add_table+0x10/0x18
	[    1.294546]  of_genpd_add_provider_simple+0x80/0x160
	[    1.298974]  cpr_probe+0x6a0/0x97c
	[    1.304092]  platform_probe+0x64/0xbc

It does seem to work correctly, with and without this patch. So I guess
another option might be to simply silence this WARN_ON(). :')

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-pm/CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com/
