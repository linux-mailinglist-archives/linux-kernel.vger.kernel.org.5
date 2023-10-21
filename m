Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0227D1A15
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjJUAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJUAx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC06D6E;
        Fri, 20 Oct 2023 17:53:22 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF9CF6607359;
        Sat, 21 Oct 2023 01:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849597;
        bh=0IPbKOlYAuxZjBnpVfqr8VjQjy3v3COiDwyaZF3CO2Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dNxPtYsb3ML0SuQ3PePvkq6TIovKoO2E2QRR+PrYODpuy4QysO6pIAwTKp4p0OL+R
         +Ew1I5DNyoWYfJojaUKEiDVcVrfnBn39bDZroQ3N/l7hxD0BABKMZ3au9uLJ7OTAPD
         V0QwUFT/dAKnUJJX23EfX+9yvSvv62qVi/+EPDj3HL6RnCoaPMwYaQa4NfDhrFMn2I
         tURKAEHvO009nU5I6T/PRe1UWbAA9j6t4UhlZ+kDuIeL2n2SFyQ02x8L50qEIMOnjM
         lz6Em0soTu6FDIFslIsN3IvZR4j2HGryFaPNTOkC/K7RCASKCu/+AuEQIgH7y27yel
         t94PhKSSIRo6w==
Received: by mercury (Postfix, from userid 1000)
        id 453DB106614C; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009172923.2457844-19-robh@kernel.org>
References: <20231009172923.2457844-19-robh@kernel.org>
Subject: Re: [PATCH] power: reset: vexpress: Use device_get_match_data()
Message-Id: <169784959127.1512524.5220065585276994688.b4-ty@collabora.com>
Date:   Sat, 21 Oct 2023 02:53:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 12:29:14 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] power: reset: vexpress: Use device_get_match_data()
      commit: 469d31745b9fb3a87424b311abb7cb530611404f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

