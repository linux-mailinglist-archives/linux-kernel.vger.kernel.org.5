Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98721759A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGSPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjGSPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:49:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2EE47;
        Wed, 19 Jul 2023 08:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4rMDx2upczqirFTTJ8y6PzSq7Q/FIh8AgQOI4r2OjkY4M+A3ce/Vo8A2KebGDxC3dknrbwgloIgNlPq5KggQwkGgnCflGKWipPJqTpwJIt5HCeoVtbncb/pg5YZqi++8u8KHHD47oPxHeK3hk7HK86twCjXsTIImjn3X1OxIqy50FWZuZ3b2klQspjk+M/6ay3tE36mT0S0dHvlwVO/bBQEjXBIztWW74efFg7x69G/i80mF0kstoI8/0rPxHGf5Tugp/QiCX5978q2lN2i7YASTlFyOdV65M5MlxoBfE5cw1JXa7k11e9ssphpX1yW9qsGzBLHj/UwzDWfs0IhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPZY1OWRvTc4Ccp2lVRUuz5xugjRbxsMLkexykdrms0=;
 b=fw6nRfweNzratlU/PbkYiqW1Vmc32hnbb9JW6xHNC7uSpK1hHG59Z/r2KgLJ5XjP+UgReZGrfRlDrLZywNJfiSryQq+lZ0+VPnUWkICgLjFuzwdYGXlhUiqbJ+uM4MknfN4Jii2oQM0BvbD3MBL56GnCVpZH4LXt4nQvg4ehErs55sE4JeOdO17NFYvFFPvTJ/evZ/4gk8PgFvOEnZKoUyc1UBjC8x6jEa5KKJkcRo7juOsU6WF5Y+xQNfe8g32ttf1d7Nr/hKwmdTXD0o+k8H8jae6FlxrGAlPhmznwz5O4iTeoTZ+gTxWgY2aCb7k1hhYnuEd7DnmVEd/NJ+0XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPZY1OWRvTc4Ccp2lVRUuz5xugjRbxsMLkexykdrms0=;
 b=A6hKzJD5h4K3nrbAjUP2Vc02Wy6aBlTquDnEYyeqmEKAEhCyfnlw1/GQ4wd1RYfSVLYZv7/ITB9Zrad51XOahiqAKFEpPFUwXymP8+dtr5goJ65gPc5K3KDRTrTzXi+qT1tdF08Y4nAK8C151N6TqfexpGFdT0iGsnvbKVtVUQWAxnQ4XPiNzJ4mxs99b0+YV+IDsDIfF+nQMpLlBMOfB4J8cg0mAR/pkbWPXQTGr//5c3hOpp4LlXUyrxTlxjTmDxW2DhZW8oSO/bFsXKXpuen0R960k/BMomLGqUu8katEteaxD03hqwNbosHnqI6BAMdNVaprtPfbtmcTMgRBMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 15:49:41 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 15:49:41 +0000
Date:   Wed, 19 Jul 2023 23:49:18 +0800
From:   joeyli <jlee@suse.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20230719154918.GJ14791@linux-l9pv.suse>
References: <20230718034337.23502-1-jlee@suse.com>
 <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PA4PR04MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: adbd0a4d-5ff1-4ee9-c2a0-08db886fc3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xHR9KX0esjqoq6Ysiv3PQsYnd2/VOuRcAavB8Uv4llKYcT74a9IlAqtdzC2YezL/2PVgcq1Jvi9VD6wSZC/t+ZRmUH132acYTHITwTPJZx47TvnGNszMxmN1zgtymYO9K5n30Dv9fKVa8rpoD1p1+5U9S6yKTfF2LajEqy//gP5Lt2VI3SO3QvBDx5BTBJTVpkcU9HlBsCvDO5+kUyCwOvBiU2miFeAMJWcyQcyvC+PYhHWKyHOyDzsVW3XtAFVSJF+JkdykfEs5ONKYGJFw9xQXuEnF1yyi9+/vQkOKIbJLH+TwYwyTI9z+xvN5iBL7r3F8sq0Lk3+kWQFJ0NYgMqA6FBg43nt1yWERw8V9jXg9udujaG5U/b67br79Rhk+Gxc3NIXxNyIiSSebXCkKpgVKoHMSIwe9txK7BZGzZnSgf9qmoPSCyEM8bi5dphpa0YeOBRfJPH/Z1NWLKc3uKTNDdMMMGAwQ7Tp9f23dQ+SmCfBK8HLqpnOcvUoK4lomfwmswv7AX34evgPGdJrw2AyWTIQlKw4Bu95fZRq4xnWl4X6OM3JqVQuB59HY166Yoeo9i/8MKXpWJNdxEybrYAoAogWyfPzOah8wmkwIVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(86362001)(478600001)(83380400001)(1076003)(38100700002)(186003)(41300700001)(26005)(33656002)(54906003)(316002)(53546011)(8676002)(8936002)(6916009)(2906002)(4326008)(6512007)(66556008)(9686003)(66946007)(966005)(6486002)(66476007)(6666004)(6506007)(36756003)(5660300002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdQTTUyREJqQnhkNjIyYVg3QUNsb1grOUgxMjF3ZG42SUtzTFhiMmpEMWV6?=
 =?utf-8?B?SjNZenNocDE1YXRLa1J5Sk1VaTRXdUE5ak03QkNkODk4cjI5b05CL09HVzQ2?=
 =?utf-8?B?V0hOWlZ1cnUyMlBFTUVmSFQ0NVgya2dGdGZTZHhsaGNXa3FVc1M3dlczd3Q0?=
 =?utf-8?B?NHBaUFRpTE41bW0wTHE1SWV3dTdRMndlemEyeGJwMFpqYm5SYkpUY0VIVWdD?=
 =?utf-8?B?bmNHUUxUSjlaS1E3WlJZNWVrY1luclVOOGMrTTlNV3B1ZUFDZ0VnWkNGR0h1?=
 =?utf-8?B?WDJPOUdvdUgzSjRYMXV5WEtjMDV2QjNlMnJYN1dXbytZUG11b3NFVHczTjcr?=
 =?utf-8?B?bXVLNW0vejV6NDVtY21XSHlHQlowWk14Sjg2RFRrY2VxRW9pSjkvSnpxWWRT?=
 =?utf-8?B?R2o4a01iMHl0RDBqRnFaWitPNXJpY1Z5cGhNNXE5Um9ZaWlLUExaVmdzMFdn?=
 =?utf-8?B?TjNORGpZSGFQWXVJbXlHWXpoU3NLcmVBS2RveEtEWlY2RWNxc0JCdW4xU0dv?=
 =?utf-8?B?eUhpVENjdjVMNHdURkYwUEhLb1h6T3ZmWmM1OURyeFUzSGNWczNZZ1pLNEoy?=
 =?utf-8?B?MHJ0V3hkY2FVZ1BrWS8wTTdVU1JkK3NnQ3pqZWlEaDRtamYzMTBueWZqV3Er?=
 =?utf-8?B?T3Q2Q0ZqTm5sL3d5c09sOGoxWGlDdGErKzhQL0Z0OTlZcENpOFdTcWhNREg1?=
 =?utf-8?B?ajRVL3hObzBpRUhiMVk2QU9kdFozdXNQemhpckk2cWRBcDV6MDdwemIzYlpa?=
 =?utf-8?B?eEVKaVhwNmtvUWY2TzFER1ZUbE5tY1JKU1ZKTDJBeEJnRlEyenRicDhvT2FJ?=
 =?utf-8?B?cmpGaTJva1BGU1R0aWF5TU1yTGgvT2dnRzFKYTBEY2dWSllTRk9tNmJuVVJm?=
 =?utf-8?B?VURGVTdSZENEaFNnRkRHVHNaTjNhRG1idGxVREluUGJ1ZXVVbTJ4WlV3cGNl?=
 =?utf-8?B?V3V4SU1RQkJZaEM2TEpMQWZNQ3pzVUVHV0tGZFFxZjNaYXZIc3ZLOGIxQ0Y0?=
 =?utf-8?B?Vm9VMTZ4ZWZvcHhGUHZ4MlF5SU5oV04xNlE4VmdES1QzbmNvcW5lblNsdE5M?=
 =?utf-8?B?ZlJUUXRQcVZ2TVFwb1VDUW0zTGRVZEhyVUg1NW9ZUTNLUzAvT2xocnV6NDdG?=
 =?utf-8?B?amVBL2hSVmx5V0gyZk1QR3JzcFgwbEVINWJ5M0NHc0xWN0ZXNllHZ2hOUkF4?=
 =?utf-8?B?bXljdkRtMjJDN1JmTSs2U2xkRU1pakc1dEdjcHYxZmFHc2pCZU0rUThhZ0hK?=
 =?utf-8?B?dFkzZThiYkZKLzR0eW1LZFNCTGFIZEN5QnYwT2J5V29Zd21wTnd4V3ZDZmJ6?=
 =?utf-8?B?RDdERHBmd01ndG11ekFrU2RHK1BHNDF4NGZjMXJoVlNVd2k5aW55Q2k1aDZ1?=
 =?utf-8?B?OHVCUUJzSzdVMkM0cnRIQTVXVFphU1ZDa2ZwQmIvWVpEWmNTOThKU3Z2UkVZ?=
 =?utf-8?B?aW1WS1VhMUNJQWVnd0NpbzQvTVRaaWVBYjhYNXRpRFV2a0NBZ1JGZ2RGYWVX?=
 =?utf-8?B?dmdUZFdCYnBTRitTdkJjSUd1NUlvWHlkSm9IUWxsUVdWTjVrK1g1RXhYcUtK?=
 =?utf-8?B?RjlhZk55U3dDMS9HcVZUam9uVGphRjl3czc4L0pzUVFDaWxLYzdOV1QzelJ6?=
 =?utf-8?B?Q2I5c0RaMjVXRjhmc3Q1d0hhbUVkNHJhTGUwcCt3dVNvWVJJM2VHdG1KbVNC?=
 =?utf-8?B?SUxSemdVWkh5SnJOdzVobVBTYzE4OEFDZjc5UW43UkVnL1BYVnlYZ2l5eGZs?=
 =?utf-8?B?N0pwMlp0cDkwYkdlOXAxdzhYbDY3b1d5VzNpL2FMOHB2alJaSWF6bmJiMkVt?=
 =?utf-8?B?NUhFdm1aaFZ3bXVhalNLSk1RTWV0YS9RbFlDM2cyL2NoTjZpQzc3clhBbEJZ?=
 =?utf-8?B?SGtOcUVwSmZQWHh3eDg5dlhWV1ExVzhJSCt0YkdMU214T1dESm92bXNXVGll?=
 =?utf-8?B?aDRKU21iUllaYWdlWms4Y1pXV3ZnMEhHYllHUzlMTVFOQkx0Z1F2T1BKVUZl?=
 =?utf-8?B?NjQ0aXh1MmdEK01pY0tEOVpYRXo0S3o3eFk5c1RQZkowbE4wNHB1ckxhZ1Vh?=
 =?utf-8?B?NlNkemFGd21KaXpQdGxLY0lKUlpSYlV3eEZ6UlBycjBZOFVxZURnNjBtb1Uw?=
 =?utf-8?Q?zUnI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbd0a4d-5ff1-4ee9-c2a0-08db886fc3f8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:49:41.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VwfyF76PD7IkocfldSoT3MUIR3R7Y/8WG0uLj4wfrdP8gpCoQ0V2QuupQX6IqCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7760
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz Augusto von Dentz, 

On Tue, Jul 18, 2023 at 10:22:26AM -0700, Luiz Augusto von Dentz wrote:
> Hi Chun-Yi,
> 
> On Mon, Jul 17, 2023 at 8:43 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This change is used to relieve CVE-2020-26555. The description of the
> > CVE:
> >
> > Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> > 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> > the BD_ADDR of the peer device to complete pairing without knowledge
> > of the PIN. [1]
> 
> Btw, it is probably worth mentioning that in BR/EDR the key generation
> is actually handled in the controller, below HCI.
>

Yes, the key generation be handled by link manager. I will mention it
in patch description. 
 
> > The detail of this attack is in IEEE paper:
> > BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
> > [2]
> >
> > It's a reflection attack. Base on the paper, attacker can induce the
> > attacked target to generate null link key (zero key) without PIN code.
> >
> > We can ignore null link key in the handler of "Link Key Notification
> > event" to relieve the attack. A similar implementation also shows in
> > btstack project. [3]
> 
> Perhaps we could clarify this statement by stating that if we ignore
> the link key it means the stack will not consider the device is bonded
> and will not persist the link key, that said the controller will still
> consider it as paired, so I perhaps we should go one step forward and
> disconnect if we detect such a key is being used.
>

I am new on bluetooth field. Did you mean like this patch? Sending
HCI_Disconnect when we found zero link key?

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ff0c331f53d6..3482031cbbb8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4698,6 +4700,15 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
        if (!conn)
                goto unlock;
 
+       /* Ignore NULL link key against CVE-2020-26555 */
+       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+               hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+               hci_conn_drop(conn);
+               goto unlock;
+       }
+
        hci_conn_hold(conn);
        conn->disc_timeout = HCI_DISCONN_TIMEOUT;
        hci_conn_drop(conn);


Is there anything I'm missing? Thanks a lot!

> > v2:
> > - Used Link: tag instead of Closes:
> > - Used bt_dev_dbg instead of BT_DBG
> > - Added Fixes: tag
> >
> > Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
> > Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
> > Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
> > Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  net/bluetooth/hci_event.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 95816a938cea..ff0c331f53d6 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
> >         bool persistent;
> >         u8 pin_len = 0;
> >
> > +       /* Ignore NULL link key against CVE-2020-26555 */
> > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
> > +               return;
> > +       }
> > +
> >         bt_dev_dbg(hdev, "");
> >
> >         hci_dev_lock(hdev);
> > --
> > 2.35.3
> >

Thanks a lot!
Joey Lee
