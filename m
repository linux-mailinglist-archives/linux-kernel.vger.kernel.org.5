Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07F79D9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjILThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjILThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:37:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA04CCF;
        Tue, 12 Sep 2023 12:37:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE92C433C8;
        Tue, 12 Sep 2023 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694547437;
        bh=gd3JSCFNlZNOc17omch31mn3SEDOmklsNDFzW1IJUqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbTtVZPDkRAQ7dtnkVFHRojKfguuphEXogRqYBllIgHGtZ5qVtTRkle/WSYcx+xcG
         R0NUutds3YuEQeGmQC3wTv3GIrHQ/FJpUfWSe8tKT7C8SSUy3oT01qdynWiRuPGkQY
         gQa7hmtAYoFVtcub/f8ASQWGy8E4HCIFm3uQyvgsLMz1jp0De/hujZuXXpZkZlCBd1
         Pg7qqT/3w6VbDBGFxuVMJyO8z6hGsmLNJEXfX14BUmjwymBUcFwD1Q4EMxW77uh3o2
         ekhysq7CzJAk8qi/3zDd34cggNB718QHCJFQVIBgnLT115gCYftw/lv8tW1DxxfGcc
         7C8N5hybdmFnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AADF4403F4; Tue, 12 Sep 2023 16:37:14 -0300 (-03)
Date:   Tue, 12 Sep 2023 16:37:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf test: Update cs_etm testcase for Arm ETE
Message-ID: <ZQC96oT8uYMDmkXh@kernel.org>
References: <20230911065541.91293-1-tianruidong@linux.alibaba.com>
 <446ec4c1-e97f-a5a1-9830-693dd7eec52d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446ec4c1-e97f-a5a1-9830-693dd7eec52d@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 11, 2023 at 09:51:09AM +0100, James Clark escreveu:
> On 11/09/2023 07:55, Ruidong Tian wrote:
> >  	# Iterate for every ETM device
> > -	for dev in /sys/bus/coresight/devices/etm*; do
> > +	for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
> >  
> >  		# Find the ETM device belonging to which CPU
> >  		cpu=`cat $dev/cpu`
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

