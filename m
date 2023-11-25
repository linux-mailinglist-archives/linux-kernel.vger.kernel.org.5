Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F87F8820
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjKYDYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:24:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F71B2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:24:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E85C433C7;
        Sat, 25 Nov 2023 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700882649;
        bh=Dr/cM1vM6EddpUQmfjLcvcCsG7fZOQeUYmdcw+IGsrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8pWhOotFPWTUhpf7Wi/DOZFtBuTojhbbG/TmFrPUFTPZoAc1tMZ10pYMr0M0dqVV
         RCG1nwD+goEPAee1DWIUsp6V2/oDG98+MqtXmOnRWbmvxhWEUwGuaweLNXf1Ajz2a+
         lh36NE4JSK0PuSQ6HlQayoKTEnapVq85QXb17E9Ap6KVKgZT/vc7tJuKLx/wV1Gg2x
         bDmw9bkpfzASKzsya+MfNFWCXb/jYOV3qoYkmZNktEV7GTos15kZCS6JT/ok5iScIY
         ThLcgpscfqLWeRt4DW4ElDGwUgQa5Hq8lqnp5xjGHkyZUOCaYkhpMfnMGz0m9bamES
         2cYzc2mKt1QhQ==
Date:   Fri, 24 Nov 2023 19:24:07 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124192407.7a8eea2c@kernel.org>
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> Jakub could you create a stable branch for this patch and share the branch
> information? This way other Maintainers can then pull the patch.

Tagged at:

git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loader-add-upload-error
