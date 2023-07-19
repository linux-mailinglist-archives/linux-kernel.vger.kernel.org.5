Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB47598A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGSOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:41:07 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 07:41:03 PDT
Received: from mx-relay02-hz2.antispameurope.com (mx-relay02-hz2.antispameurope.com [83.246.65.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4110E5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:41:03 -0700 (PDT)
Received: from mail-db8eur05lp2108.outbound.protection.outlook.com ([104.47.17.108]) by mx-relay02-hz2.antispameurope.com;
 Wed, 19 Jul 2023 16:38:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XABJg9bd0SBmWzGkpitxJfcxFtJQwf2J7FqXtr076laGL+j7TtClHAl918xvZ4Ep+kl0eIhZL9YH0XkBa3I5oTT/W4L/2cYp8i8pOVbUU+WAzTjjtMw6O6NkVbxh6zaPmTmt6NqxuLlMrDbaDbTfhMDsyH7tvjzeUQQ/T1YqDV0U2yOJAUJEmC5hToEhhNiE6+2CiB1IZSxs45uaWbO1WqLbvjQhltZhehpSmHAyffOttd+maKqaDiScDDyhunYcbYrNCHdSDmsZXbmkcGuMqKoraAbOkDpva1twkoYNJ4NYn3ivihMyVVxTc0tCED/Z6I9G96oK1ffCHo6IAKLjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+AvUZLVXKu3IF296eS9AAjGituhvWjEj5fVHa/ScWk=;
 b=UY1ez/pQK0ix99CMtKnjdQa6XXt+K4v9L5ekP6FKQwOYd7FJdFEVZhAL0YjBtdUWsU9Lf7rTGK9J7soR/o21ddzq9UEB+iLUplu9U+t0aGculKWIeJlqNjzQuPvkiYDzau64dcqHfZy9M2p45ZV3cFZMTIGhY1g7VprFuUi+RcGK3ioLOkDTQ7EvOLRz/nWcdUhVJoZIKRlTBO0W1neiqmHAhekEtEtcidIJWpIe1J/mJd8IQAv8LKspm/M4GaUqTXmjrVT/8Tmt1rsGlkrFOU1HbhiTl0CWkkH1jxToi6b44w0amcaW7lV0SPqktfE4LTDxQUR3mLkP1/C9tLEh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+AvUZLVXKu3IF296eS9AAjGituhvWjEj5fVHa/ScWk=;
 b=RxC+TVgZvJrww1bB8Ta6/aoyDKrZXcY03SEQhDKUKhQ0uMKd9OkXBkzyRMObxsoG8qnn++RuoQQp1g30eqP7Sm32EZ1C3wAlBGymXMjjNPnQ6bQlMxRiNdcm0IeZSicWov1AYAUXWWDD5vsZGu9Xvp9Qn7AXep4ZtZorQq6Ij+o=
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::5)
 by AS4PR10MB5173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 14:38:49 +0000
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d]) by DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d%7]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 14:38:49 +0000
From:   "Wurm, Stephan" <Stephan.Wurm@a-eberle.de>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eigner, Johannes" <Johannes.Eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Thread-Topic: ubiblock: null pointer dereference using scatterlist in
 work_queue
Thread-Index: Adm6TrtbCPM7Wc9tHEqQjN/cd/Xt9Q==
Date:   Wed, 19 Jul 2023 14:38:49 +0000
Message-ID: <ZLf1dqe1DUhfXQ4R@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
 <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
 <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
 <260741266.3681.1689591789332.JavaMail.zimbra@nod.at>
 <ZLVWfrlEOWT1twpr@PC-LX-Wurm>
 <1006337471.13025.1689777115644.JavaMail.zimbra@nod.at>
In-Reply-To: <1006337471.13025.1689777115644.JavaMail.zimbra@nod.at>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:424::5)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB7436:EE_|AS4PR10MB5173:EE_
x-ms-office365-filtering-correlation-id: 09f4a4e5-e797-4e1e-ac4c-08db8865dddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgsaOO5Eh+LDZEi8p3+S8q0OhOI2oIYC/nXzdCZUKOIH+J5SCzFY+cS54pRZ3p7OYb8bxIaDPWdjpFb9UWGwn4C3lwXSGC2g9fy8CDBn4fdZd6UuQ1mIi0vfwO5FJTvZIc/p2QyvTKv48sUPDxTzQ+SXDhIT0KXCTBZKGXwvdVx0xuKhd7yYKgWiwx6kZ7wg+bGDkRI2qYmy0wzb2vuFOrnNwdv66D0iSmBN4OqXVZvsa7UXMswj5zvyPhnM/ucLS5LDM3tdE6+SNl955xVuVqIHVufPNTQmQZ+8p23M8v+Zz9tWqbEviHk/kswKPILGCwQp17bC73k/1aioW/pGhk7ZI+waP+9Aa8hb96GGtQiPqUve3GQoEEXa2ep1RaVfJui0jrjjSV+qb5Sokvt9jeTTHaIpw7FtMLV4UcQtxz45FhocylcBFedWmI187TvEE9fcMpl1vW86Cmu+0Qo4G1jqOVJO4GwApCmIup3AfNQluHSO2Wp+xm1GejIJMD1mR6xLGH58DvnTmQsye2bGF3KfI0TuMxiFVqTf+p4SJSObY2mLzP6eixFzDCi/siys
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39840400004)(376002)(136003)(396003)(366004)(346002)(451199021)(4744005)(2906002)(41300700001)(316002)(5660300002)(8676002)(86362001)(8936002)(33716001)(6512007)(107886003)(9686003)(6506007)(478600001)(6486002)(71200400001)(83380400001)(186003)(66574015)(38100700002)(6916009)(122000001)(4326008)(66446008)(66476007)(66556008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0V3OHk4YnQraHZZVTN5TzJjUG1lQjVjSlVtNmlYc0ExOTNrcTh6Wk1tZkxN?=
 =?utf-8?B?dTU0Qzcvd0Z2cVpTK3hvSVhNZWh0VHk0V0NpNkNxMVJUdm0xWnVEa1ZJWVJE?=
 =?utf-8?B?elppNEJCY0Z0dlhOUTJKTVFSTnBIOWVpeE8xYWpCNVJBeHhDeS9UaHlaVmFs?=
 =?utf-8?B?RGZaNkgydktCb3FjRVpGTy9oSE1hZ3JING83cDhseWFUUWpYZHJhWGp1QVFk?=
 =?utf-8?B?azZFZmU3UCtpSTFCbjkvb1BOdExyS3pteEIrV1c0bXh4amQ0ei91RkRQNTBK?=
 =?utf-8?B?aEJleCt4cWlBNlpLenFPN0RXV2JiWXJsS0hnV0pwRmZENE1YZE9EWlR2Y2xK?=
 =?utf-8?B?SmVTT0ZtMFV6ZUdCS1pDUlZ2c1pDcy9SOUV5S0NiWDcyUktjdmZQS1pYVG8v?=
 =?utf-8?B?UEhVQ2tmbWNzd1VLZ3lpTEZRNE5ZNVE0czJvbnJnTENFMzJXaXVCN281b3NV?=
 =?utf-8?B?S3J0dCs4NHJXSHVMNHFheDNjYktmeFVIckdBZmJyUmdhY0hyQnBraUVucEhL?=
 =?utf-8?B?a2x1Z1UvczM2VDY2TjRmYWhLOTQ3dFFrb1NpTFVGVU9iRXFJSzUwRFRjMy9R?=
 =?utf-8?B?VUFOL2k5eTIwU01IZGpRV0NtVFh1RVpjR2l3NjZOelgyRGZaaHBxbWRCbU8v?=
 =?utf-8?B?K2hWRitGODNtSnI1dWtKZWU1ZG8xcWZzcnZRZGVhQ2FhZU5HbGFDaU1HQ3NI?=
 =?utf-8?B?Zml2bFhYRmhWR2VWRUphZU1VeDkvU2sxRFRyU2JWdWs5ZVZpQlNZRTNoWVFQ?=
 =?utf-8?B?NndkOGRwanYyTmJ4TkVJMlhIUGptcWZTYmdQNWU1SkVTc0hiUHpmbm5qeEJp?=
 =?utf-8?B?cnpSai93aWgrdTJqWmF2S3JIL2daWGNPL0QxRnF3Q2lLM0t3bVQ3bFJJVi9i?=
 =?utf-8?B?WGZlMDJDSmJHSEJQL3JBbk9ySERyRDJaZDZHVVZBcE1ySnE3TkdrTElObnlI?=
 =?utf-8?B?bzVEMGJMTnFRQ1VtYnpzZ0Jtc284Z1gvbXExSnhzc085YUpSWVdsanYweCtG?=
 =?utf-8?B?eVp6SGhzRVVRV1ZqQ3YwbWFWbFRZVjZEK3pVcjcvM3hwR01KRjJpZVlPMnJN?=
 =?utf-8?B?cjJ5YzVYcWdWUTAvTE5uZEZ6ZVpZWk96RXhjd3NrN05kNFZpQy9qTlJIRjdk?=
 =?utf-8?B?Y3UzbkhsSFgwelVOYXZ6U3lONnJiV1V1bGZZY3Ayd3NnWXV6ME1jR3BYUXI5?=
 =?utf-8?B?NUJlRXljYTB2SDZSSlpiWU9lcjFSWVUwejBTLzVmajNWRW9uUGprVTI0N1Fh?=
 =?utf-8?B?b2VUWkV6Sk5ibit1S1h1aEV5amJ3YVNBckM5dVBReW9UaUlhUUNVVUxKdkZB?=
 =?utf-8?B?SEErQUJYY0tiMnZBT3dZUzV6NFBqTXhiMUJjWjB0R3VlcFRNbGVIOXlLMEdy?=
 =?utf-8?B?NUpZMzBhRm9GRmZpRVk0OEZtYjNhTll6Q0c3QXdkNEFRODZOODE3NSszS2N2?=
 =?utf-8?B?di9idit2U0NwM2p1aVJFWExXT0NzZTFrWm9SZDhWcUtVdzFCSHo5WDZDVDdS?=
 =?utf-8?B?aDBjclowdUlISG4wSGkxU1UzYitRTmFjL0hYQ2kvWjFkc3lSdGJEd3g5RHZW?=
 =?utf-8?B?MGNCTXhiSmFuOGp6cTk2L2h3V2M3T2Z6blJQWDBEa21DdGF2bTBRNENSVVAz?=
 =?utf-8?B?MWdzRWUwUklXSUNpd2hsanlYYWxKR0Y5T3ZuMEtnK1VZVU4xYmxwa3BFWTNG?=
 =?utf-8?B?VzdKaTBLcExCdHRycHE2Y1Vnc3lUVHBSaVBqMk1ObEdNOXd1Z2p4TjBoWitG?=
 =?utf-8?B?cUJITTN6UEcvOW9qWGEvU1kvQXVPaXAwWTBwa2VDUE50a1VwN1NrdEYxRVls?=
 =?utf-8?B?eXdmTDVjODlpN1Y0ZkI4ZkZWZjM1QmRkdklPVFlSdE1DK2R0OXhBUjN2RFph?=
 =?utf-8?B?UitYcmRQVnBEcWdmalIyMVZlQk9DZkdRTnAxbG9oUHBZUGxuS1F6KzQvazlV?=
 =?utf-8?B?Mm1sT3Z2Mk1vZHduZUIwdlpXdGhzVVRjb1VRdncvUmhjSmxxampSNHBpY0Mv?=
 =?utf-8?B?VHJmckVJQS9Odi8rb29HWEV3enM4RktrT3FZY2w2bFNrSXNnc21LdXdQRFhv?=
 =?utf-8?B?M05hRk9zaGxJeFptQWZsREhrZEhzKzlScGMrdUR5cTlBVklqc2pndWNJQnVh?=
 =?utf-8?B?TVdVS1czcnR0TXdjVGpXb3EzSFpndXcySkhxRHc5UHhBRmV5RExzTUU2RmZR?=
 =?utf-8?B?d1ZZeWJkdE5BRGZEc05ZV084NzhHajFZcWsyKzkrQUVEV0JjM1FjNnE0MnVQ?=
 =?utf-8?B?ajlqQzRua1J4eDBRUjZqZHovbG5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0482C1EDCD1D4B43870E85127E17F096@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f4a4e5-e797-4e1e-ac4c-08db8865dddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 14:38:49.7735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjcvkGdid2wTSoj8RyAM6daekBHtmgpmkv9MAnPwU2VweGl9Gexjo2TnjgjU6+jOm8vCjxivxJzan75As+eK3o/KmgGCEVwKZTe2u5yV8as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5173
X-cloud-security-sender: stephan.wurm@a-eberle.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz2.antispameurope.com with 44FD51161981
X-cloud-security-connect: mail-db8eur05lp2108.outbound.protection.outlook.com[104.47.17.108], TLS=1, IP=104.47.17.108
X-cloud-security-Digest: 10d7d79d7f0191d3c34922a589ba97a7
X-cloud-security: scantime:2.971
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTkuMDcuMjAyMyB1bSAxNjozMSBoYXQgUmljaGFyZCBXZWluYmVyZ2VyIGdlc2NocmllYmVu
Og0KPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tDQo+ID4gVm9uOiAiU3RlcGhhbiBX
dXJtIiA8c3RlcGhhbi53dXJtQGEtZWJlcmxlLmRlPg0KPiA+PiA+IFdlIGRpZCBub3QgY2hlY2sg
b3RoZXIgc3RhY2tlZCBkZXZpY2VzLCBidXQgd2UnbGwgZ2l2ZSB0aGlzIGEgdHJ5Lg0KPg0KPiBE
aWQgeW91IGZpbmQgdGhlIHRpbWUgdG8gY2hlY2sgd2l0aCBkbWNyeXB0Pw0KVW5mb3J0dW5hdGVs
eSBub3QuIEkgYW0gc3RpbGwgcHJlcGFyaW5nIHRoaXMgYW5kIEkgZG8gbm90IGhhdmUgYWNjZXNz
IG9uDQp0aGUgaGFyZHdhcmUgdW50aWwgRnJpZGF5Lg0KDQo+IEp1c3QgdG8gZ2l2ZSBtZSBhIGhp
bnQgd2hlcmUgdG8gc3RhcnQgbG9va2luZy4NCj4gSSdtIHN0aWxsIGEgbGl0dGxlIHB1enpsZWQg
d2hhdCBpcyBnb2luZyBvbiBoZXJlLg0KWWVzLCB0aGlzIGlzIHJlYWxseSBzdHJhbmdlLi4uDQoN
Cg0KVGhhbmtzDQotLQ0KU3RlcGhhbiBXdXJtIDxzdGVwaGFuLnd1cm1AYS1lYmVybGUuZGU+DQo=
