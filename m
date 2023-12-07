Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F5E808DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjLGQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjLGQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:49:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB610CB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:49:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E721DC433C7;
        Thu,  7 Dec 2023 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701967788;
        bh=6EVDXG4leM9LTdHsAL/O+acBrm8fkXeWhlMQuWIDXMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC0jwMhdtTRmLlxREzCVcuIiNbAq1EGvWBJXJ3sXt1hs5S6LIrDznGK8ayCB2lziz
         i3tuDO24f76Z4DmKNSymDDrijmoi7DwvWLjNS3FWaxQlQsPsKOXbcEbSniMed8HrEG
         z+gCA1Pd8jdEC4x5sRV0xTeNsOECwRhYYdeC1vZrLeYczZyXiyDoxU9MLLklayOqmG
         qk51YFFo+fCL8X4lANUyBpXwe65zzRPpT7J62X1HTMYCth2fKw2Jlqg2EPCJsbPPa1
         o+5oaT0q+ivbOOiYLt5yWGrOUjZ3fi6doXQCh2B03k3Iq0jrN7Ta+VXMJFDLpp1mZ9
         k29zopz9ydbZA==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware: microchip: Replace of_device.h with explicit include
Date:   Thu,  7 Dec 2023 16:48:53 +0000
Message-Id: <20231207-automated-juicy-0111b9763e0b@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207161430.2570611-1-robh@kernel.org>
References: <20231207161430.2570611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=660; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=2qdrbgEm2nvzreXwZ3xVhmrEL0wwV1Cm9Cjy8w834fs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmF34vKlyjEpft+rfoi/14yudmsQmXa1Qw2TS8FPYaFP ButGl91lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCLVZgz/7HI8d0d/KZd/0aNV 3st2/krXbaeJG6MnKk6KTNm8suOQJCPDsye63RtVZ655/zlL9GryH5siWfXoVxrmD2668O1P3m7 CAAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 07 Dec 2023 10:14:30 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. Soon the implicit includes are going to be removed.
> 
> of_device.h isn't needed, but platform_device.h is.
> 
> [...]

Sorry about that Rob.. I'll also add the maintainers coverage you
noticed was missing.

[1/1] firmware: microchip: Replace of_device.h with explicit include
      https://git.kernel.org/conor/c/405820eae72f

Thanks,
Conor.
