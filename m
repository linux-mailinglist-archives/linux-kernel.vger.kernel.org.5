Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636F806373
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376301AbjLFAbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376278AbjLFAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:31:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE81A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:31:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D7C433C7;
        Wed,  6 Dec 2023 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701822674;
        bh=tIFx2XxJ5bvW9JQGHgDBOs+eDppl3xUZugwLevpr3qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JGZeVHNquOWVPkK1aHSw/EuPSMasgAqQbNWWuuXTKejfvlT9d/LpO4dUaOKhD+vQv
         PRgi3JxovXJWfyBJpahmLjDVZTSN9D7KniXtQwqMIgYG+jX+tLvwlLCzVZTE01UNMX
         vU+YMWiLECw7lfLjDoec7fbinreJoOgSaNJhluBkSOayqV+Jz27mJwk94Cgc6rWEVw
         Bk7p/3dgn0dhkXLtbSroeIuV93pYCivcXPgeyxvaV5Ex+Wp55ZKiEgtreC4HSegkBo
         TCaLHE9iah0To6+YWxDPYLxuIABEoBv98h6kt+jIODxq7NKgYQVn49OcVGkU/47xWH
         eFrIp1QeP2o+A==
Date:   Tue, 5 Dec 2023 18:31:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/7] PCI: Log device type during enumeration
Message-ID: <20231206003112.GA696026@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205171119.680358-2-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 11:11:13AM -0600, Bjorn Helgaas wrote:
> +		"PCIe Upstream Switch Port",
> +		"PCIe Downstream Switch Port",

Nit: I think I would change these to "PCIe Switch Upstream Port" and
"PCIe Switch Downstream Port" because that's the usual usage in the
spec.
