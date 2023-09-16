Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67E7A3253
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjIPTwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjIPTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:52:18 -0400
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8D90
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=fezrpIaIpQxdaG2CC4X62gW75ZqMToSOm+5V/o22VUg=;
        b=VT+TV471gEc1E3zHRWfBlEo9MhYeIBvrxDTb6GIP0sJBCCIkujy8aSTtwuvqWW+L0kdbMAvpFiTF5
         06Wkucd6Yj/85cL9xqdcPfy6L6a8rEV1hK3zcsQyDCNc3sqfWO4olwuvDV7E8ruBYoYdwIKptd5yst
         41kG1JKyUHOyfOYSWr4MhjnnVXlvTgQT7UsgF2/NNueL66rxh12bdWYn2PG7utDO48BXvQFVlUMv4n
         Fb1spmH6NhltIIhUF7IaCPlmp4CAxkc8GBqJhEAZxDiHCpKy0N5nPk5XWqrSMiR32tiGGYZdwqzklq
         4HmbE8Vs2TgAlrPRDRS+cy8WZsQ8+Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=fezrpIaIpQxdaG2CC4X62gW75ZqMToSOm+5V/o22VUg=;
        b=w4PKBPRv9vrkQO3B3Qk3e/3d3yIWHWBxdbAL5WgOfG2AMY6O1uq1fUm8N1l3x4/NsJdgJIhLvlRhO
         6w/KjtmBQ==
X-HalOne-ID: 5f1579ed-54ca-11ee-8b67-118fcd41062f
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 5f1579ed-54ca-11ee-8b67-118fcd41062f;
        Sat, 16 Sep 2023 19:51:07 +0000 (UTC)
Date:   Sat, 16 Sep 2023 21:51:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier.carrasco@wolfvision.net,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] dt-bindings: rtc: pcf8523: Convert to YAML
Message-ID: <20230916195105.GA213821@ravnborg.org>
References: <20230905220826.79901-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905220826.79901-1-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
On Tue, Sep 05, 2023 at 07:08:26PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert the PCF8523 bindings from text format to YAML.
> 
> The YAML format is preferred as it allows validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Looks good,
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume the dt people (or rtc people) will land this.

	Sam
