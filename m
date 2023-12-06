Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE658076D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjLFRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjLFRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:45:22 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0D122;
        Wed,  6 Dec 2023 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GE1VPm5btBMd9mwfn4sOjYmloAWowP1CRL1VphR/cGk=;
        b=MeLK9sxS71BKJZtcAMnuP3Y/B0MjbmYnI6eXktt1U2K1EcLNjVjwTHXvc14As0RrfZSswJQaF13
        /Ob7ps4nSFUGGxxclRMWR65tPVdZ2Z6Y3sHPwdUN5/lNHk2nn2idIjM5u1GJmNUE8d6yQcslIBeUC
        Azjf8vIu/9olYRiUnpMMDnHcqmzpMqb+1a9Mvjf5hK/QXiApvNBlMuI9R1zqZ5+/Tpmmvy9qlqqAf
        M2U7LHXfdQmMsw7o0VW9PzMHShVIie/KtGfQ9j3LxX8S+eOPAxdQIGiUXBMmH4RXRvDQx8/aAClwW
        GOHDT/I1CHqXwaN9HOl5UVLAnZit1PrVn84w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1rAvxb-0008mt-Tq; Wed, 06 Dec 2023 18:45:23 +0100
Received: from [2a06:4004:10df:0:b8be:58d4:e5aa:7fa7] (helo=smtpclient.apple)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1rAvxb-0009aj-6S; Wed, 06 Dec 2023 18:45:23 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20231206173543.ag7xb4vhcjknyiyv@skbuf>
Date:   Wed, 6 Dec 2023 18:45:12 +0100
Cc:     Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Arun.Ramadoss@microchip.com, ceggers@arri.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2244A511-6F6F-4711-9BE0-30786B021AE5@geanix.com>
References: <20231206071655.1626479-1-sean@geanix.com>
 <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
 <20231206173543.ag7xb4vhcjknyiyv@skbuf>
To:     Vladimir Oltean <olteanv@gmail.com>, Madhuri.Sripada@microchip.com
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27115/Wed Dec  6 09:44:21 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir and Madhuri,

> On 6 Dec 2023, at 18.35, Vladimir Oltean <olteanv@gmail.com> wrote:
>=20
> On Wed, Dec 06, 2023 at 05:22:55PM +0000, =
Madhuri.Sripada@microchip.com wrote:
>> NULL check is missing here.

Did here what every other driver does, that uses the =
connect_tag_protocol() method.
(As per Vladimir=E2=80=99s instructions)
Not one of them, does a NULL check.

>=20
> Don't just leave it there, also explain why.

Message to me?

/Sean=
