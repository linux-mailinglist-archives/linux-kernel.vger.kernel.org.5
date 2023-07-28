Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF6766FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjG1OtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbjG1Os7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:48:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A155F12D;
        Fri, 28 Jul 2023 07:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPQv9PP+VWC2HwtykGy+oBozEj+BLxoQcMZ3icUTQVC5CrPt8J8F8JWqu+qw5LZJzVbgGtk8/T5UF/xju9uOnP2pphKaJVNCXWu8E07XyYUtEEySRpyWIKeKW6H9GUm9hSk60Z9iZOZrOUPFAJcxF3HRG4H7EvJ+5vBg9rqTNL9R5g9ZyYsFmGSEaw34pDyVARFgHgCFbFgkzhDgasPzyCh4mMjODC8veGB+tVFW+8D+G5Kgy0PuM5Z3X3oooig44ObNQ7O2VkUmsJLgNa1cB0ivH3NlDh013qhSOjgc6TZjBAP/PDg4mJckLy4UfpO2Z2KeYX4NQ8s7AikzmnEZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6RF/4KPdw/u7XzZGhMhPzNqFA1dY8mcIrqqGRXJb0c=;
 b=Iu1fe1Qsu52RLWaQYvFfml1f7sY6l4BYxQbI0NyYiMEOLHRhGIHWxjbARqngDG9bf6vA9+r9/pJcJU5k21q6yECphOeHN3NALMyNeglOs39DDm4h0r/3OVmTc3IEGnUIMT910dV5YL510G3gNqHN3fF5pr/A9X6IV3n8twfUl2bn4aXS7rAEUO5DeIATH9NYlEF797k4FeDbHMks0v9UI9YyRG79tjxXoT77iqJ9UYT78ApeipPi0zkHaI+6UXQyoNevaQAZ/iQP2mZBTLQX3z1AEB4fo4CFaBvAKM4z378tnAG6Z52bD/G/t9DL4g42BfR1km0EvvVO9yj4wVN06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6RF/4KPdw/u7XzZGhMhPzNqFA1dY8mcIrqqGRXJb0c=;
 b=Iq63m73o/uHYbmS58sHW8eDg8n/Gj5WagC275D0ZUosB1PK2h3SkPk+iEg/rddr1RZg9R0wxrW13/g6ZrX36QRlTaST1d/jlLnzCN4OCC5ZAtV4cositXyudKVczIOjyAiBsb2ZxBkVQW8wiqnGzRXYRTlMlVU+Z6wTPmUilagvof04rPIfj4PQBnKyn2FL7HdziTk4yLosKYZZeJ7mT8zwSCQ1GcoAByXcjI5DYpzCm1BOT3sHCZHT/NRJgrp1SblDg3PyDTN3R8AA6z4QCkEP3yKW6tflBAzLbHrtRwMDunZqic7befVH/DJhmTcophfDWRpGeCSeRvYf+grHT2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:48:55 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:48:55 +0000
Date:   Fri, 28 Jul 2023 22:48:42 +0800
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
Message-ID: <20230728144842.GA14791@linux-l9pv.suse>
References: <20230718034337.23502-1-jlee@suse.com>
 <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
 <20230719154918.GJ14791@linux-l9pv.suse>
 <CABBYNZLKJTKwBeypHbwm1r2CnqY+S2pY6dLYri+Z-otEx-UQ6A@mail.gmail.com>
 <CABBYNZJZisYm0Vgfzd8F2ge9RPJvUYBVGpj-4iySerT_wUTJNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJZisYm0Vgfzd8F2ge9RPJvUYBVGpj-4iySerT_wUTJNA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0268.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::13) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 841bdf1e-e3a8-4bff-dbc5-08db8f79c439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDP/mk9JopwjYASGq5FwqGyn6vBQ+ZB5As8A/3/tdJf4Wpz7/ixzzyqM/e9dnBHji7A84SfipkLIj/YfxtYFClpyFRpPdrH3Nue+fwiVkfN2nH0ik2nPhYk4lREvsmWWG4cfLZpifgzAyLNAVUFoe15BmoJEFKN91PB3wdrFk5LQC6HK7TZlPNSyydS8fBfN4PJnPelY6woctW+WEwBJYw4mGhNbTlu+7FbLWao0VRpM4pPZXmElde0h3A2De5Yi42uW3ZxxLtdSCCtkn2EPEpgfAKrm27gKveUc974kG/fBgPE05V4tVqOhM8zuPP6KqG8/nOXsihL0KxUK3iavxkedxXSCf+NSx3TNG6KayPRvmFU1n9TTzObuiLQS/ud1uHmTP77IJTaC0HeLck3izFPP/HwJl87CqC9mugWtIR4v6AWjoMK4AjiTrX51ilhsQe7DaHgJlVCM5fspadoLcyiqZQKo99RmtkBd7IPAG3vM9FgRvbXXywKIHOehNcfix9yra15/v438QjAWT7sB5eHYi9l7zwdJsOrFr+gG5FAMsjTn2D56fI20Pe9ePwY5At3gea68rk/cyIztQzSAkNMN5Yh2q+wPpJgncyKbM58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(478600001)(6666004)(966005)(6486002)(54906003)(6512007)(9686003)(83380400001)(33656002)(86362001)(36756003)(2906002)(66946007)(53546011)(66556008)(66476007)(186003)(1076003)(6916009)(6506007)(26005)(38100700002)(316002)(8936002)(5660300002)(41300700001)(8676002)(4326008)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykc3Mm44U3RYenVTaEZpdEY4THJNZ0E3YzAzb1JYNmZ0WWNIT2ZHeEoxeWJS?=
 =?utf-8?B?NDlQRVRlZXBDRnVVMUVmVFRrZTZtdWR5dC9zYVNoK1VCWmN5WXpiTlRQYTZo?=
 =?utf-8?B?bEY0ZXBPcTJJQ0dNdEo3NGxTVUJ0UWlzcnZMc081QmRKQlQ0djZnRFFyMm9p?=
 =?utf-8?B?YlNVQlhudlVkZlczSlp0UFI4N1lZREk0blBlL2JZa25SdjhaUTB1d01kQzlk?=
 =?utf-8?B?anVHU1B5NjJqQkJBbnREQ0EyTzRPMHIreGM0UGcvOVVRdVU2cy9wWExoekQz?=
 =?utf-8?B?TnJINjFYVXBlODlFQTlKTVY4ZFNQbTJFUTc4WWhTZGpMeS8zUFBIVVhNMHBy?=
 =?utf-8?B?YnlKd1RKSEx6QlVqUWRXcjJoWkMrWGMrQmJpa29JVGtDMUQ5RGdiSlFDVVNQ?=
 =?utf-8?B?Y3lmYkY1TWkwNThncWV0clNzaCt0dlhOdVo5V0lsMGV5M0k2RzMrOWhRWHY1?=
 =?utf-8?B?U3VLczlwUVk4KzB2azhHekMrQnM5a2RsdGlCcENRNHJZRGUzclhMOGtOb05o?=
 =?utf-8?B?M3BBN3pxdjFKbmxhQWdDSUNBcjdmMWhRRmpseVhsWkJwSExkYUNSVStDSTNE?=
 =?utf-8?B?aTVaOUVaUmVqbFRxL1JnVUN4cGFKc1pmcFpwbHVaUllKVzhOWmVhWEZmd0ox?=
 =?utf-8?B?NE90ZTN6dzUrS0g1VnY1NXIyVzRqdk4zVEFma1dnWUdkdFljME5HR3VUcTFp?=
 =?utf-8?B?dzVjQ2xyV29adEdLK3JLOUNDSlFzQ0ExTkt6N3Z4K1EyQVhNWElsRlRsMlVG?=
 =?utf-8?B?c3dzUTdaNUhSdldHRUFRTFgyN0E2cllOMUlvei9mSkdNZXMyOUpNdmM5bThn?=
 =?utf-8?B?TzRJb1g0ZTJuNy9YazZLeStNQy9MVnA5WlRjZHNGSGtBWGI4RExaUWZNZTdY?=
 =?utf-8?B?QitQVjdFeUl0OUw3d1dzREJ3RGc0S1pDUTM3T3RrSDU3VFlQS1Q3WVNGcy9u?=
 =?utf-8?B?T2VQMTJOOEVLWmh2bnZzWGk2S2MzVUVreVBKWGNqQW85RythSDdnNkJmc0wv?=
 =?utf-8?B?eDNiU1FlVkQvNklSOGlzb0tBTm14MkdoVUExcG01WXoyZXhFbENPbjU5d2dY?=
 =?utf-8?B?U1cycUl2VGc5WVluN2pjU1h3RitkWlJvam5DWDJETHNKNjVud2luaEViUHZJ?=
 =?utf-8?B?VTIyZzRUVUYwYXhEVjJoU3g1RWozVEV6MGJVWThEVFZ0M3dmKzU2SGtGN3JM?=
 =?utf-8?B?QzYyRkpxcnVHWHZFM1lMb3EvQnJtdVRXem1Hbk1SbG1tWjUyYUl6WFU3S1pK?=
 =?utf-8?B?V3VITmV5R3F3ZzVTYkh2bitOdTF3cm1wOTRyTmt0Y2QvejMrMXZjV3F2ZDZ0?=
 =?utf-8?B?ZVNrc3E4N3hTTW01dG4vb3dmTExzemp3QUF1MUxJbmZibTg3aHVOZkpiSER1?=
 =?utf-8?B?elEzN0xKN0pFMEI0WjFhYVplK3pqN3QzZWxqcDZ6TlFjQm5zNGhQU0NHaWt5?=
 =?utf-8?B?WjJiYVRlZUtxN0pTUU1nWS95Q1JYNGlLeFpEYjJxQ3NVV2wzUzJ4aWhtbG5Q?=
 =?utf-8?B?UVVQSnM1M1FDdDQ3WFJ5ME9QSFF6TE92MkZZZGtqSlN6cjV4SkhPYnJkSVhs?=
 =?utf-8?B?eGlTNEdielBPYTZSZWxhYnhvbCtIN2I4K0lOYjRRclR4eUk3YVh0SHFndEJm?=
 =?utf-8?B?Z1lncFhBN1hEYk5kTWJuZkF4SEw1ZHRFaFZkOG9kZTI3UGk0MmV2RVFFZ254?=
 =?utf-8?B?azVVQjdjQ1lsMHpwVEZVaURTdlQrZkxjdzZJVVFjZlplMVE0b2NPQTNWWWh4?=
 =?utf-8?B?Ti9sNTZxVTMwazZocVE4Rk01RzVGTUU3L29INVJBYS9nUXFCaHZ4bWM4Y0py?=
 =?utf-8?B?akhYU0twVkxhZDZBSjZKVFc5NEw2bUVWMDJTNXFRSVFLaHR3aDNkdHV6RFll?=
 =?utf-8?B?U2dteE5lMERCeDhxK3FvWUhqUmNER2xBRy8zRnNZRkoyTWJobUhsUlNKM3V6?=
 =?utf-8?B?UGNpWkhYZGkycXlWVjZMbGNIZHFvUGhsQmJ1TFZqWE9NU3ppSUJaKzJnRVZC?=
 =?utf-8?B?MldNL1pZKzhUMC8zSWxXNkJwU0tCck1TeEYzU2xpUy9NY1RpTWEwVk5Hallx?=
 =?utf-8?B?VE5iUDdZTk82WGV6RXAwOGUwc2Noc3ZzVjA0VURBQTVxZ0dYY3ZMRVFTcThq?=
 =?utf-8?Q?vTs8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841bdf1e-e3a8-4bff-dbc5-08db8f79c439
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:48:55.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLDEv1cLSgndqlpE7Qc/nvOZvajAzjpHD+ZiWCSRTLqzdS/uambkqvF+V0gXax3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz Augusto von Dentz,

On Thu, Jul 27, 2023 at 03:29:42PM -0700, Luiz Augusto von Dentz wrote:
> Hi Joeyli,
> 
> On Wed, Jul 19, 2023 at 5:25 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Joeyli,
> >
> > On Wed, Jul 19, 2023 at 8:49 AM joeyli <jlee@suse.com> wrote:
> > >
> > > Hi Luiz Augusto von Dentz,
> > >
> > > On Tue, Jul 18, 2023 at 10:22:26AM -0700, Luiz Augusto von Dentz wrote:
> > > > Hi Chun-Yi,
> > > >
> > > > On Mon, Jul 17, 2023 at 8:43 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > > >
> > > > > This change is used to relieve CVE-2020-26555. The description of the
> > > > > CVE:
> > > > >
> > > > > Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> > > > > 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> > > > > the BD_ADDR of the peer device to complete pairing without knowledge
> > > > > of the PIN. [1]
> > > >
> > > > Btw, it is probably worth mentioning that in BR/EDR the key generation
> > > > is actually handled in the controller, below HCI.
> > > >
> > >
> > > Yes, the key generation be handled by link manager. I will mention it
> > > in patch description.
> > >
> > > > > The detail of this attack is in IEEE paper:
> > > > > BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
> > > > > [2]
> > > > >
> > > > > It's a reflection attack. Base on the paper, attacker can induce the
> > > > > attacked target to generate null link key (zero key) without PIN code.
> > > > >
> > > > > We can ignore null link key in the handler of "Link Key Notification
> > > > > event" to relieve the attack. A similar implementation also shows in
> > > > > btstack project. [3]
> > > >
> > > > Perhaps we could clarify this statement by stating that if we ignore
> > > > the link key it means the stack will not consider the device is bonded
> > > > and will not persist the link key, that said the controller will still
> > > > consider it as paired, so I perhaps we should go one step forward and
> > > > disconnect if we detect such a key is being used.
> > > >
> > >
> > > I am new on bluetooth field. Did you mean like this patch? Sending
> > > HCI_Disconnect when we found zero link key?
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index ff0c331f53d6..3482031cbbb8 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -4698,6 +4700,15 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
> > >         if (!conn)
> > >                 goto unlock;
> > >
> > > +       /* Ignore NULL link key against CVE-2020-26555 */
> > > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
> > > +               hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
> > > +               hci_conn_drop(conn);
> > > +               goto unlock;
> > > +       }
> >
> > Yeah, something like that should do it, btw I hope you are testing
> > these changes do actually work properly, even better if you could
> > introduce a test into the likes of mgmt-tester to generate a ZERO_KEY
> > so we are not caught by surprise if something doesn't quite work as
> > expected, or some change cause a regression where this key is accepted
> > again.
> 
> Are you still planning on updating these changes so we can apply it?
>

Sorry for my delay! I am stucking at other stuff.

I will improve the patch and send new version again.

THanks a lot!
Joey Lee
 
> > >         hci_conn_hold(conn);
> > >         conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > >         hci_conn_drop(conn);
> > >
> > >
> > > Is there anything I'm missing? Thanks a lot!
> > >
> > > > > v2:
> > > > > - Used Link: tag instead of Closes:
> > > > > - Used bt_dev_dbg instead of BT_DBG
> > > > > - Added Fixes: tag
> > > > >
> > > > > Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
> > > > > Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
> > > > > Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
> > > > > Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
> > > > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > > > ---
> > > > >  net/bluetooth/hci_event.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > > index 95816a938cea..ff0c331f53d6 100644
> > > > > --- a/net/bluetooth/hci_event.c
> > > > > +++ b/net/bluetooth/hci_event.c
> > > > > @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
> > > > >         bool persistent;
> > > > >         u8 pin_len = 0;
> > > > >
> > > > > +       /* Ignore NULL link key against CVE-2020-26555 */
> > > > > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > > > > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > >         bt_dev_dbg(hdev, "");
> > > > >
> > > > >         hci_dev_lock(hdev);
> > > > > --
> > > > > 2.35.3
> > > > >
> > >
> > > Thanks a lot!
> > > Joey Lee
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
