Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE41806A41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377173AbjLFJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjLFJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:01:06 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFB2307D;
        Wed,  6 Dec 2023 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N1jod1FzkmkyxyVQNDl6jeYBZoBJ7X9ZIXt3HjQG3ww=;
        b=p9e6tLHGOQyi4rJ1HvNgO197jfZkk7UuwH1lNpexEYEl+LZ2UI1nOHzifcPYe7aPeTwg2KqbzVd
        kYGkvJEb4nI++qmSp0rsNXZAGHUBI6+zdWs3BG+Hy7THmpQ/nngTKVt0KpImDJVLyLCw2jwF3v9qp
        IDH9/K9vWQ7GcUndNYnlOjBGb8x/i/0iDd3EDZWTKSOVcXND3YwJnBockhIDigXPVo924gLEmgLp5
        ypJGSbG2bWBT6Q+uZdKwKy567yEb2BK0XbJD/uxSR5oxLg9N6ymy58jbongX4i/4g/F3CcNvoBlD8
        RiFbWiUYZTJ0Kc5g3TUzYZPZs3tl7Opg6lPQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1rAnmB-0000yr-L2; Wed, 06 Dec 2023 10:01:03 +0100
Received: from [185.17.218.86] (helo=smtpclient.apple)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1rAnmB-000LsT-0z; Wed, 06 Dec 2023 10:01:03 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without _VALUE
 define
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <DM5PR11MB0076D755B7492A38337A6A7DEF84A@DM5PR11MB0076.namprd11.prod.outlook.com>
Date:   Wed, 6 Dec 2023 10:00:52 +0100
Cc:     Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0DA4901-0C2F-4D4D-966F-BF89C67219DD@geanix.com>
References: <20231206072442.1628505-1-sean@geanix.com>
 <DM5PR11MB0076D755B7492A38337A6A7DEF84A@DM5PR11MB0076.namprd11.prod.outlook.com>
To:     Arun.Ramadoss@microchip.com
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arun,

> On 6 Dec 2023, at 09.58, <Arun.Ramadoss@microchip.com> =
<Arun.Ramadoss@microchip.com> wrote:
>=20
> Hi Sean,
>=20
>> -----Original Message-----
>> From: Sean Nyekjaer <sean@geanix.com>
>> Sent: Wednesday, December 6, 2023 12:55 PM
>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>;
>> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Andrew Lunn
>> <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>; Vladimir =
Oltean
>> <olteanv@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Paolo Abeni <pabeni@redhat.com>; Arun Ramadoss - I17769
>> <Arun.Ramadoss@microchip.com>
>> Cc: Sean Nyekjaer <sean@geanix.com>; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without
>> _VALUE define
>>=20
>> [Some people who received this message don't often get email from
>> sean@geanix.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>=20
>> EXTERNAL EMAIL: Do not click links or open attachments unless you =
know the
>> content is safe
>>=20
>> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
>> DSA_TAG_PROTO_LAN937X to improve readability.
>>=20
>> Fixes: 99b16df0cd52 ("net: dsa: microchip: lan937x: add =
dsa_tag_protocol")
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> Not sure, whether it is a bug fix or not. Since it only improves =
readability.
> I believe it should point to net-next.=20
>=20

Agree :)

Feel free to remove the Fixes tag while applying.

/Sean=
