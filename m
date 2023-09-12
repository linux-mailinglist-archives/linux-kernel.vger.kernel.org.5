Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5879CC33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjILJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjILJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:46:10 -0400
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F312E;
        Tue, 12 Sep 2023 02:46:06 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:964:4b04:3697:f6ff:fe5d:314])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 38C9jlhs2694909
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 10:45:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1694511942; bh=X2URSJTAIH9XGYPY5u1jK+7QAYG+vRNE7Qvlgkh1qt0=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=JH0xqut8NY90pGGDTJYGyax7Gv3P+H09MElGcEp9/TaJWHotRk4FhBleIS1rGQyci
         cAPdOuuckn7mKuQ+fjUBZ9oBYiu7AZ/krshVMf0MDzD93+47eDBdAdSaG+V1RNsKT+
         H5TsJIvZD1SOZt4ByFYprV10jaNn5R1f/BQjv5Js=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e0:8300:13c:9450:7f1:fd90])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 38C9jfUu133726
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 11:45:41 +0200
Received: (nullmailer pid 142914 invoked by uid 1000);
        Tue, 12 Sep 2023 09:45:36 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Stefan x Nilsson <stefan.x.nilsson@axis.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH net-next] qmi_wwan: Add rawip module param
Organization: m
References: <20230912-qmiraw-v1-1-21bc812fa0cf@axis.com>
        <87a5tramab.fsf@miraculix.mork.no>
        <42522712-b739-3db4-9111-a4b378a65809@axis.com>
Date:   Tue, 12 Sep 2023 11:45:36 +0200
In-Reply-To: <42522712-b739-3db4-9111-a4b378a65809@axis.com> (Stefan
        x. Nilsson's message of "Tue, 12 Sep 2023 09:44:26 +0200")
Message-ID: <874jjzafnj.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.1 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan x Nilsson <stefan.x.nilsson@axis.com> writes:

> Would a quirk on the affected modem be an better/acceptable solution?

More acceptable but still needs justification.

I'm probably missing something, but I don't see the described issue even
if I assume a device crashing if it sees an ethernet header.

The netdev and associated chardev are created when a USB device is
connected.  The device knows nothing about this.  It answers a few USB
descriptor requests and that's it.  The host is free to switch the
netdev to raw-ip framing before bringing it up.  There is no need to
send any frames with eithernet header.  There is no relationship between
framing and the QMI control channel.  But the host is in complete
control of any communication there too, so it wouldn't be a problam if
there were.


Bj=C3=B8rn
