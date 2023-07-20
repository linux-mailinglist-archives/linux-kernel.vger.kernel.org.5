Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE4975AD6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGTLv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGTLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79122EC;
        Thu, 20 Jul 2023 04:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE4D61A3E;
        Thu, 20 Jul 2023 11:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A1DC433C8;
        Thu, 20 Jul 2023 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689853910;
        bh=KwFfQmyt/+0DpciVBrQ1+N82moIDcZwodNJDNDtjVOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJYcZAVrk9PL8figg2MOG2Z5OzlkQEBgR8yoGRShFbtEKIhXhFeadndXw39mQpiZ1
         8RrekHekgpETp7hNfj61ehG46Vf0kwvWspUq7azFO8iGo8PgeEKM3s2sPZ4i19jLYU
         NR1Y7DcGc77rMGjiuvk/IzSu2n+Txfahcc7A/84Dk5mzi4haKOWfpL+H3kSeuOSi71
         z27iDcApEzUla2lR1RI990SIhxX8EtF5N6/lXIFNqRuorHRtXmH2oXUbYARr6eE/Cc
         kUF9l7FY0MB4eaY+XqlnkelHykLdp2AcFAochQOy9oRZ4RCAww5Of11vBtJb9Y4TGy
         S0oqTX0mCIgSw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMSCM-00021A-0c;
        Thu, 20 Jul 2023 13:51:58 +0200
Date:   Thu, 20 Jul 2023 13:51:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mohsen Tahmasebi <moh53n@moh53n.ir>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mostafaghrr@gmail.com
Subject: Re: [PATCH v2] USB: serial: option: add Quectel EC200A module support
Message-ID: <ZLkf3leIihlMScSY@hovoldconsulting.com>
References: <ZLjkC88x39tEX28c@hovoldconsulting.com>
 <20230720113105.20320-1-moh53n@moh53n.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720113105.20320-1-moh53n@moh53n.ir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:00:25PM +0330, Mohsen Tahmasebi wrote:
> Thanks for the tips Johan, I'll do better next time.
> Yes, the device supports RNDIS mode with the same PID and you can
> switch with a AT command, so I think it should be ECM/RNDIS.

Thanks for clarifying. I'll update the commit message accordingly.

Johan
