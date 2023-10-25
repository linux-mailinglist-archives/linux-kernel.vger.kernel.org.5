Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7A7D6B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjJYMYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjJYMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:24:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D013D;
        Wed, 25 Oct 2023 05:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790E1C433C7;
        Wed, 25 Oct 2023 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236678;
        bh=bSqqHMVrLE2p2KXzPxKAUj5EAEySNGDGKAQl8sg/cd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyFd1EWTdVN2lxnS39uPc9hCivr3ihlFMHBDVc4iBVFz2HoXjX4hJbCnrB3Ni/Gu9
         C1j4cKXnYWkrEv0B1smstVP/NviqBtFABLPMMPT+sZhtXh+ItwaDgzmGwoUZdAGSGJ
         8+D2KLS2379wiiJDbwwj9oEtXtZM2mmC1SwspVSrjx44Mw40wRgelww5qtYqgJTyqm
         uwDYR2Cp2vnt/b9llLS2hFurewavtRjCSmLAM/TDSmd+Srjrklr062zfPjTcslhnlb
         XL9/nxEY82ffWaNt3DLkPhZPEDMzUWQJ0eF3Z7Zw9Uyn0uqiWlbqeQa7PTT9ldQhWt
         AtA87O40EKD8g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvcwU-0006Eh-1O;
        Wed, 25 Oct 2023 14:24:58 +0200
Date:   Wed, 25 Oct 2023 14:24:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid
 implementation
Message-ID: <ZTkJGh1twK7o0QQi@hovoldconsulting.com>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <169823622555.724579.17090745891924053957.b4-ty@kernel.org>
 <20231025121827.GN8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025121827.GN8909@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:18:27PM +0100, Lee Jones wrote:
> On Wed, 25 Oct 2023, Lee Jones wrote:
> > On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:

> > > Included is also a rename of the SPMI device lookup helper which can
> > > hopefully help prevent similar leaks from being reintroduced.

> > Applied, thanks!
> > 
> > [4/5] spmi: document spmi_device_from_of() refcounting
> >       commit: 7db72c01ae2359dbab29f4a60cda49757cf84516
> > [5/5] spmi: rename spmi device lookup helper
> >       (no commit info)
> 
> Not entirely sure why B4 is sending out these separately!
> 
> Still, both applied, thanks.

Thanks for taking these, and thanks for the acks Stephen!

Johan
