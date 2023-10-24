Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD307D4AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjJXIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJXIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:51:44 -0400
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 01:51:41 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45811110;
        Tue, 24 Oct 2023 01:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698137313; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dCcByXA50jlPc/5462sZaBYKE1yLuq8didSSqCaiBubc/EXXEqja6NYRBlfmv/CznH
    yY3b9Vr8Ha1wBKqnHAtCoSDJu+S6cjyBBSKyUfRatTBjbpJ4X0+E1G7uEW3pqljWqm4W
    u+Xb+evtzvEwK1GeQosGn45YP1mtRhOIvbNbQt3eKqLKr6SQLzGKOdPmKjM4Vpk7Mlv1
    WP0mC2COCNREel8omco3oWrfJJIXNtuOsmCf1Rhyg+dBfpkTHjkYP6sNmSeCoUh1ZHQF
    zYGJHKece8em7+Qs04hf4oKbYgkZdS3rgvHqIqxiRYZSBDJJwFEFsLGDMEgQ5+1mlDyf
    lYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=RAOA5Yq4NAHi1lIYy9fPITpAgKff26SsILB/yW7T6nHf5CnvVhAAGkKjC2IfqNaWP6
    u1Q5fr7hqcOpzATNQYVaFHuyKAOsNWI49DZ0UfLUJt12TGh8fJtcze4tS4uR1+usmjvR
    8c7gVEmsrOPEY5In93JSNg2RQO+WkKjhB3Ohk4mjap+rng/2FWSQJUxbXbHU5jN/EnL3
    j2TV3lKJy+bYwmRXbFoJCTs6rasJtKBY9QYfPVxrXmBeRl7/V1Q7UfQgcObeo6q3/OnJ
    eT6fCc7I4DqB6lIKyp6CkWwNRWOxJdiqRVhfTpfnHQjBC3sSW1qdOn8QWl6WIeADMq4J
    hZrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=E2HUeYhcKPAGXcpVmL6LqqrMrF7Ib5R4o0KvG+smrDoI22sZJ+0L8/jX4/xlgN+f3N
    z+WyigESPlkHNmR1fQakN1a6hdwhgtDP80tJUWDoEqTu86iEDBGSvQxUdEy5D+iR/Ixb
    9E22vSQ5dIaYhiR1dTQAtIQ1NB7f5497UtmL4EH3DQp7UAmfr1h6UMLHpPqXqAr1rEuN
    85A8piSKfmxjzR77X5gDbMHuYu5b5Qp7sRToLmarTcvZQEB1Dcbx65fEWr8g4HPJ0dQ1
    X9GxoUSNJHDzdtFFZt4fiXj7SAX5+dS6dk/ue8mAN8yXWZ5af3VcMZ6PWC66i3bHobOv
    D2BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0003; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=rfzJINJNKVbLLy68yENYq1w7rR9Eo54SM0TqV2JqOUk6QkZFpiK29+LQbTdcWCt4go
    yEkVyJWl1w+392W9JGBg==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+0odACkA=="
Received: from JADEVM-DRA
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id U33eaez9O8mWZhh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 24 Oct 2023 10:48:32 +0200 (CEST)
Date:   Tue, 24 Oct 2023 10:48:31 +0200
From:   Dominic Rath <dominic.rath@ibv-augsburg.net>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>, bahle@ibv-augsburg.de,
        rath@ibv-augsburg.de
Subject: Re: [PATCH v3 3/5] irqchip/gic-v3-its: Split allocation from
 initialisation of its_node
Message-ID: <20231024084831.GA3788@JADEVM-DRA>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
 <20231006125929.48591-4-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006125929.48591-4-lpieralisi@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 06, 2023 at 02:59:27PM +0200, Lorenzo Pieralisi wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In order to pave the way for more fancy quirk handling without making
> more of a mess of this terrible driver, split the allocation of the
> ITS descriptor (its_node) from the actual probing.

it seems that this change breaks MSI-X (MSI?) reception on at least
the TI AM64x, probably most/all of TI's recent devices (K3).

These devices rely on a quirk CONFIG_SOCIONEXT_SYNQUACER_PREITS that
uses an address from the dts specified e.g. as

  socionext,synquacer-pre-its = <0x1000000 0x400000>;

to configure a MSI base address that differs from the ARM default.

With this change, the quirk still sets its->get_msi_base and clears
IRQ_DOMAIN_FLAG_ISOLATED_MSI from its->msi_domain_flags during
its_of_probe, but both get overwritten again during its_probe_one
with the defaults.

Previously the defaults would be set first and then the quirks were
applied.

I have no idea whether TI's use of this quirk was "correct", but it did
work, and since 6.6-rc6 MSI-X has been broken for us.

Best Regards,
Dominic
