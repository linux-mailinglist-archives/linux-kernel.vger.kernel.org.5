Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA67C8296
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJMJzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjJMJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616FCF;
        Fri, 13 Oct 2023 02:54:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA47C433C8;
        Fri, 13 Oct 2023 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697190895;
        bh=9J/gUGQJF+i2xToDCp7xkcqH1AHvLaMUpe4GDX1emeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk3gOpzOe7+nxSX93FfS5IWfTGSH+Bz8CmYvs2nuZFfG+85fh7kyOZns7JEd/yDEN
         3EVMxFvX7Q9JupMIuWuITjENqXZ6TkRL/A0yXRC6cBPMmOrMGtHWrbNILE7neJX5Bn
         5tmNnyDYt74ql+V5DCLAQhTzZDs7VTHS5xAg6EW4DAQsGLR+ozI6+hplJyFVq/ktqG
         L3vXtVTdmOpqt7jCa2UUvlUue85H7WYdI6ruPj7i/tQwDtXZr2GINKej6CdvTAFoNx
         pfQjfyrBol2+r9VScDY6Y3YvEiMF1Nawi5R+lWgjy8XU7RQLd0Vata7LfJ/gaRKmyW
         IK+gGCzHuf7LA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qrEtC-00065u-1X;
        Fri, 13 Oct 2023 11:55:27 +0200
Date:   Fri, 13 Oct 2023 11:55:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid
 implementation
Message-ID: <ZSkUDl6bIQkArUO0@hovoldconsulting.com>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <169710605745.1174112.5043840678154728515.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169710605745.1174112.5043840678154728515.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:20:57AM +0100, Lee Jones wrote:
> On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:
> > The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> > that can lead to resource leaks and crashes. This series reworks the
> > implementation so that can be used safely.
> > 
> > Included is also a rename of the SPMI device lookup helper which can
> > hopefully help prevent similar leaks from being reintroduced.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] mfd: qcom-spmi-pmic: fix reference leaks in revid helper
>       commit: 365cf70ff33fe20e749227346d7245f7f0dccb58
> [2/5] mfd: qcom-spmi-pmic: fix revid implementation
>       commit: 7370f9de463b1d21dcdf9480a0a15babecd14ac7
> [3/5] mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
>       commit: b5cd5e72a71e9d368e20271d3a772dd045ae220e

Thanks for picking these up, Lee. You don't seem to have pushed these
out yet so I'm not sure if you intend to send them on for 6.6-rc or
6.7-rc1 yet.

Either way, would it be possible to include also the related and
dependant spmi cleanups?

Stephen, could you ack those changes so Lee can take them as well?

Johan
