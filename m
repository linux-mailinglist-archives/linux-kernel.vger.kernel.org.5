Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0317DD138
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjJaQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbjJaQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:08:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBFB4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:08:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9BBC433C7;
        Tue, 31 Oct 2023 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698768536;
        bh=EYfspEu3PI2rpXyzN82Cv1qtuVu6AZTOaElxhmFbG9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaNOKewa+TdgtHYvvczOhkKaAqtjDFYuwcvP57jJg0B11+7sZOBmbjRwLYRkydZBA
         1Ik4k3+ciC4eUu4X5uSA1xlGCrhAdATJQHg+UlngQKksPJziQacmUcS5qZ6r3DHBJD
         +5C4T5Q3yEKB6HXA4TXqzuO2cmRHWkjQ9ucQ3YlCYVWYiOTHOBBdwaA09bHoZtFK1Q
         Da1JtQ51Zj5fEApWCpb1/uR0+IacxhOFb+rfYgyJgV7pZaADc6QTov1fdzBpyFJHkW
         DJTAlmZ/FI3MYx1Wsq6yevm/+FkyyOyWOJboWHAOBnIH+/yR0uEy4yZB7uAF7edRYY
         xZHplcKPYhd0w==
Date:   Tue, 31 Oct 2023 10:08:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160044.20355-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
> 
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
> 
> Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Thanks, applied for nvme-6.7.
