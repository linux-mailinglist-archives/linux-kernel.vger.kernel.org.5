Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE24769005
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGaIWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjGaIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:21:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3272E41;
        Mon, 31 Jul 2023 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=EOe+l+7kjl+7rypw1+iLV+opzi+FSFKtYOJlcbNHKRQ=; b=QAJG2As5EfODtDmGp3YKLSIopz
        nuJjYbHe9Q2SMWsr3P+MfH4u1IH7UPQWj/Q5A6irrs1KijE3KLbbaWhVSA2C6ygK8X2an3lb86lFG
        dyInNHpSaJ8C1Kqu/8IUxktL461Jn6CW4uWDxMVqi1+mcChjiSxZI0zjxQeDJ/RMSSqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qQO9j-002hJV-PT; Mon, 31 Jul 2023 10:21:31 +0200
Date:   Mon, 31 Jul 2023 10:21:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <21dfb855-8f44-4a4c-9dba-52eb5ae46b9b@lunn.ch>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731041013.2950307-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send these
> commands to the AOP.

This sort of sending arbitrary binary blob commands is not liked,
since it allow user space closed source drivers. At minimum, please
provide a file per command, with the kernel marshalling parameters
into the binary format, and decoding any returned values.

       Andrew
