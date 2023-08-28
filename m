Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07B78B88C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjH1TkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjH1TkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:40:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62493BD;
        Mon, 28 Aug 2023 12:40:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD97C4E6;
        Mon, 28 Aug 2023 21:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693251519;
        bh=uyU5P7l+Uc9Xf7leo9hwYxaSLRa+AJYCSjIR5O3oH8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUEi2893N1qz5CCXqeAj7jRCEwftVYAgEVD9qPBWFNZu3S3C4FJvSQ9zxuZ0oaPFS
         rDU5OiqDXuJaRUMSzOkScqyWY29q1+zGwpWcOoS0LJNo5Ci/IwUNb5BGeOMhIpLfw4
         Fa8P4Gnmz/GUySfk4jxr1Z1ugsriayXXewcdBhao=
Date:   Mon, 28 Aug 2023 22:40:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/15] media: qcom: camss: Capture VFE CSID dependency
 in a helper function
Message-ID: <20230828194010.GF17083@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-8-bryan.odonoghue@linaro.org>
 <20230828184716.GM14596@pendragon.ideasonboard.com>
 <9fb41649-b4fb-d652-3207-7c8ff8b32f24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fb41649-b4fb-d652-3207-7c8ff8b32f24@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:37:44PM +0100, Bryan O'Donoghue wrote:
> On 28/08/2023 19:47, Laurent Pinchart wrote:
> > Hi Bryan,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Aug 23, 2023 at 11:44:36AM +0100, Bryan O'Donoghue wrote:
> >>  From sdm845 onwards we need to ensure the VFE is powered on prior to
> >> switching on the CSID.
> > 
> > Based on the discussions with Konrad in the mail thread, I would record
> > here the reason for this requirement.
> > 
> > What happens if you unconditionally power up the VFE prior to switching
> > the CSID on ? Will this break something on platforms older than SDM845 ?
> 
> vfe->power_count will bump and you will be fine.

Then maybe that would be a simpler solution than having a
device-specific power sequence ?

-- 
Regards,

Laurent Pinchart
