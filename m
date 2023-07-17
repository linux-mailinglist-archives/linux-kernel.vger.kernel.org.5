Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED919755AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGQFiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:38:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C721E5E;
        Sun, 16 Jul 2023 22:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyjnoK33X8/0a5D4mDjMN8UyvPPIY44XKaIZp4D+HP5cb5cf1FM0L/9c3SUnHcjTTfKB/MaoUVXvkDKOZGrmJWfN2aOkLjpKDQcRw2dvnPcUmqzTMp7zVratbPnLHHNSd5S6IW+sIQBts02f4VeHdArNMHFkPnvfMqco3UQAjh7xT8afzItdXSW7KihWV1WSrmxNugKYnhrkhNtbe/VAvFekK6iQxMiDDSFj66++zNTKaNMB02OKV47jpoGeVjB1btmY8MdJIHku3SA5UfwCWSk8Ti1IjgRUuqJru7paWk6YCJkOXUmOEggWCnuO0BXIdGuxZZGo8u/RJbFb8N36SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH568ORo2UOBni5jfcoFy6Wk1i0o2uo6rYhHGBDXQiI=;
 b=CMIndkdFN/lcS3QwCo2MC6RZW4n/s8rvwWtC8gtZzGaLuM2vMHIMrCkSHbNcJVytsiLif+KrCcNlp4l2nLi5iTTPV8DBgvLka2WkWwW0Nl7HafFZsXCywblP5jzSoB9Yx7Q3piLJ3YGelQTUKv8dBWqfwA4M4wT+Hy1QmAr4dsf7/Ru8urXSoJpo96euc1a4L7a1f0PzUPIPuozPeTC3JTzlzloulJBhG7xojWK1FeenGL6Hhikay/RZSW31ADAbM0SpNbXJhM73HS8oKoyx/JgXydMwvLFOMQ8fYWp+ACLflXs2voj/pRLT87IImhi8KpLhk6B7dxW0+K5c50i53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH568ORo2UOBni5jfcoFy6Wk1i0o2uo6rYhHGBDXQiI=;
 b=vP78fFsr38A+fuw6xPSavZQPnIfyjb/XQq0qewtys8WFrLM0eRaa19o06qnhJ7ahx0a/cs99AUgF3wYj+pkFfClR/LFJiPBmS+D0T27glYrdmvWCsJl9rNWSETApp+8GUX00DwUEPeaAH/FKj2C6h7wIA0DRG/gymFKZ8VfyqbPzsSkPno0EKIkBZaXylASmTQyWeZ8BD/qxvTs/QXFW1HciVz3f8DqriYWraRv3eMdIXyi6u9uddcFsYwts9XmhpDoPDwGrvFXulNyfm6YC4v9GD5JPBgly5dU5o0/gV0nae7owNZXSlrYfHyZXHtTBt9Z4S217wZcSvHqq8qfFFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 05:38:15 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:38:15 +0000
Date:   Mon, 17 Jul 2023 13:38:03 +0800
From:   joeyli <jlee@suse.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20230717053803.GN5866@linux-l9pv.suse>
References: <20230714161210.20969-1-jlee@suse.com>
 <CABBYNZJ46Lt-Y4OjT7AqXczaGyGoRTzEA0gpG4Z+91GugHwsNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ46Lt-Y4OjT7AqXczaGyGoRTzEA0gpG4Z+91GugHwsNw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: deea9419-78b2-43a6-ee0c-08db8688046f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3hOBLiTmIzEai0gNusNegn6qpfwki3vkotj7fCmUutlfbgnRbcsd7VYPP+cIFZLVFHtGLc9LTXwbKfCXBTtnsue94m/xikNzg60zvydw8RKAIDjW7cWg9LPv6SOIm0otNf0kq+nsGdw1nFkmEeqUoeWY4i4UZ8pFalcOlM7p2yBzsta5i1ZMK/siIT3YHuWj6s3xwJrukz8nRXWqpmiUgTN6edzXGyoysEd4jf+4FRQfUJpFmNQYX4XTGdxTbk4IJX0XqK2lzioKyY7HyKDpWJSvIfpdyqqjhjYqmJ34yHTzGfXenO1sgnhnaJJqb9BXdluGhUT1tmzs9zcvmjfsggv4WZBKomZ+3so5uJjfigZhTd3n4mEzFCX9Y2YMXS3Snn+4uotAqCWm6t3tsMSsKcXyBR0hD5Ia52NZoxzkrOXLfmTmJUW8axqzhmmFUKFAmsJtl07zI7GLWm9XdKt99SgN7KEeyTOlmET1hA5tgNsrDQV5axqqV6BvL2POTji33ZGqSice+JzdmRAKPBnHC1qbzcZdlAnGOJ9qMktRvQoQ89p7AlqjaSdCS6KsEZA190b3TN7mf5iWv3qJo+qsO3K4hJEm40hz+2HMFrd39g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(54906003)(38100700002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(186003)(83380400001)(966005)(6512007)(53546011)(9686003)(1076003)(26005)(6506007)(86362001)(36756003)(33656002)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNNbW5NUWNTZlJpL1BCM3pPWnJ5eVYrZnZnblZpV1hVSU9JUzBLK3Rta2V5?=
 =?utf-8?B?RXorWGtMODBVY1dGTkNwWlJPc3h0dFBSZ0tGME5FMWYvczlIajJkMEwrWEtJ?=
 =?utf-8?B?QWppL2ZQVy9DeWxPbW9PZFJjNnVvYWJ2c1N2N0kvQ2VDUUJraElIOXBsaHQv?=
 =?utf-8?B?c2RrRnNZK0lhYlJGRjUxajJBdGRzWnBUYTk0bmlQYThSVjgxSko5Vm54Y0Nj?=
 =?utf-8?B?YUJTR0Q4ZCt3SXg0em9jMEdkVFJZdmZURDYybWd4TDlCaWRNMm5iWENwVVJh?=
 =?utf-8?B?b0dSaVRjRkIwM2hxUFdETEd4cXFQb3NPRmZiZVdld211RFdQeFZEYWJNUVFl?=
 =?utf-8?B?MklVN3lxdnh4MmRXbUJEMWF1VXdwVzFPS1BTOGw1OVQya3hiS3F3TEkzVWxs?=
 =?utf-8?B?bzd4NEcyL1graGFkRXB1ODJGVndabzVLaEVKWSs1S1pZVUJEanNMdS9VWjJE?=
 =?utf-8?B?TG0zNEFsMDZ3Ump3T2gvME5XSHc3TGw4ejRlMnVoZ0JwZkIvR0RPNWh5VTFW?=
 =?utf-8?B?c2g2QTBXQkNFSm1QeU1lQWlDRG02SzBCbnRDbHRLQUEwQVovYTZIdFNSb24v?=
 =?utf-8?B?dGs4SXlZaThyeGVqTmRmdkkzUEFvZnpiYWJ4QjlvS3kyYWlSUGw4S2dFc2dV?=
 =?utf-8?B?SzBKOXZsOUNFWFR1cVhxMFFNaTQzL0swQnhBWDBmYzVZR1l0YXN3ZWIzcWVa?=
 =?utf-8?B?Ni9zaE5vbXFEZFI0QlAxRnBIb2NCcDY5bmg3TUxJeGJYcXYxZkFzQUJ6RThQ?=
 =?utf-8?B?WWhTclFSNnl3cEFYbmdiVE5tdWlhQ3cyVlBSdUxQbGhSRS91Y3JCOW03QkVp?=
 =?utf-8?B?V3Y1K3Bzb0NzS0orQVdobnQ0OFd4K2RDdC9yU3ZaRUtuUEFmOEs5RmZZQVVa?=
 =?utf-8?B?QmdVbXpDMVUyU050ejZ4YmNrVXFxVDMyckdldkpLTkQyUFZSVmpLa2hpNjNh?=
 =?utf-8?B?bzU0NzZ0Q0xXelJKSWg5cVk4MU93anNnR3JOU0IwLzlHSjJNTmdTQVY0MlRP?=
 =?utf-8?B?RXh5NWFSVldmcWo1WklLN2wycnFoakpWWE0vYUdNaVJvYzM0NnJGdjlpeU5Y?=
 =?utf-8?B?NjlLNXFkYmM1V1VSazNCQ2d2eXhFbGRGcG96d3JmZURwTUZXZEpnRFRKUjVX?=
 =?utf-8?B?U1g3RDlCVFlsRVZaR2JiN0pHUUVyZGZ0ZUhaR3MzZWp4K2ZRTXJCZGJhamNY?=
 =?utf-8?B?ZEFvMkNqUGUrMVBWdDd6dWJHK2xvL1VBNk43NHg5eS8rWjIveUtxUVM0d1Fr?=
 =?utf-8?B?cU53Unc5S1JyUEpsSnhOOEtCdnJUek13MlpMRXA2QmVJYjBIbkI0Um9hRkxp?=
 =?utf-8?B?NVVSSEwzS2hvWUFPQXhVRmowb1I4Z3ZoZUxsbXF4UlBiZy8zRlJWYkkrbkpn?=
 =?utf-8?B?UE9PR0pNY3h4N3Z2M1Y2ellGazhoditrbHRacHl5K3pzWjFhOE5TMHB5R3JW?=
 =?utf-8?B?VE5Hb0VmdFRpbi9GZExoSEwzS1IyYjE4b2NabTdRNjB5OXc3MjRLZ0FKK0tz?=
 =?utf-8?B?Y1pJSmhJbzVjL3JuWGNpZXVPMDFhaldaalk0aFpQVW81SFIxTzFhMGRscGg3?=
 =?utf-8?B?M2M5d20xeS92MWYyZ0tmcU1ycEI4eXMvdmVKODVMci9FSHhnbkFKMUIwNHBu?=
 =?utf-8?B?THo2UDhZY1BYS2FiRlJKUXcxNVIwNTBQTVJaTGxGalQxTFh6ZU1BNDZVWmg4?=
 =?utf-8?B?Q0RDOHpYbHQvR0cwR3MxWkdWSVBUelMvaXBvYnh3U1Y1OVJZc0dNbm1Oa2Zm?=
 =?utf-8?B?eE5adkZHWmNUOC9iNm5qNWNLeXJtWlBqN2U2Q1FwTmNMd3R3NHNJNzRITTh5?=
 =?utf-8?B?NGc2NHZCTWVMVmp6a21EajFwWXFqRDVGQ0hDRnoyMHBoLzFGMHdSeVlYTHly?=
 =?utf-8?B?Y2EvcGtRbG94d0xvbUxzdzhvWnIxcGdkZHJGVi9PTzM3alRYZWsva1JjWlVr?=
 =?utf-8?B?VkRSZndaMHBCVWMwQ2hFb00xNGJodGE2RStrRitPNndBZE15VjR5T0I3TEVQ?=
 =?utf-8?B?UjdLQUxJSGdwamtiYzJuSEQ5Z1Axd0hpYUdUQTRzUFcvanEvTU5pOXA5NmNZ?=
 =?utf-8?B?Mlc1dkRacS9Ca2syRzRBUklrOHEvWEtDTGtOYzBWTndNSkZBRlp2SFRGczg0?=
 =?utf-8?Q?i0QE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deea9419-78b2-43a6-ee0c-08db8688046f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 05:38:15.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4gdL8Y2lfjHK0AtDHNtW5BFLJ+lEgiLw8rcjI4sIyxPoA7h+5zjRNCkaMqhITUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz Augusto von Dentz,

First, thanks for your review!

On Fri, Jul 14, 2023 at 11:44:28AM -0700, Luiz Augusto von Dentz wrote:
> Hi Chun-Yi,
> 
> On Fri, Jul 14, 2023 at 9:14 AM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This change is used to relieve CVE-2020-26555. The description of the
> > CVE:
> >
> > Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> > 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> > the BD_ADDR of the peer device to complete pairing without knowledge
> > of the PIN. [1]
> >
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
> >
> > Closes: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
> > Closes: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
> > Closes: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
> 
> Shouldn't the last 2 be using Link: instead?
> 

Sorry for I confused Link: with Closes:. I will change all of them to Link: tag

> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  net/bluetooth/hci_event.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 95816a938cea..e81b8d6c13ba 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
> >         bool persistent;
> >         u8 pin_len = 0;
> >
> > +       /* Ignore NULL link key against CVE-2020-26555 */
> > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > +               BT_DBG("Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
> 
> Please use bt_dev_dbg instead.
>

I see! I will use bt_dev_dbg.
 
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
