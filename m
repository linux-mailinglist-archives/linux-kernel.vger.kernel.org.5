Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07571777721
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjHJLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjHJLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:34:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BF10D;
        Thu, 10 Aug 2023 04:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjRZj+cD036RHSaKz5oiEPb+TYLakftViZfjMz8WmDynQXFDzVoez+XGTYWU3jPhqh5MK0KqT2AvyTNPcfxPGxm348/l0XN5bZn9foupqECUHsiUgwWQLk76WiszqNlTxnoF7yT9fMrVFOh92oty4sKTUS+1zC/xWkc1ynyKJBCLK3aTbEPPjY0emFWRvWNMUNODN0tolualFv9UrFWP1TKCwWZbTCnDAbJpYzwAlzypWlSRZwRGxZY8XoxDIJXxxth4jgYgV+mAZUoi+uNUoUZ8Cpo9D88YgbH3tLmpcOf0kWCxd3ifxdYs+9UgYnvDz3iKdQSB3BEh+5oFj6IOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpMuvYRDaRcHxWkyzpAWJ6fma3hSWkS2g7EV+0AI7aA=;
 b=cU8+8OV1lkulduZxnrb+oj26pwDu1rtPPPw9YSeVzCoG86BqYoczL4YBcqYbXXEjks2nCNwNXECMoVGgh6R8RpFwd4eMd/IRy+a2OJxYYU46W73ZrXqdb2DeI6g7AFhfOTCJ2tvSRbr8tL8JT9AFM1PJVZ4ego+K/ZtI13/+3r0TneTBiKkGnEkGCh5Is6Ne0kIKVpJoP0FVcfBBbqfyImbgyw7X6gMDr6O7q5drN53WXoySZi5FrTo5wfL0KnRJyWif0CnuBUydTN/4MKDTiSMSIQu1/sDN3J+bupLY9DJGw3gPjPoDl4Wl9q6ildNztgo6/HWBMfS3+Zp9NPVQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpMuvYRDaRcHxWkyzpAWJ6fma3hSWkS2g7EV+0AI7aA=;
 b=X8hrLX0r6vDVMxCvZijCl6ASOWRiUebssUIERhPdwmLUl6f9HOnykKxkNBEGXLJ2qQOxV66TFUCNo0NW0fp4ruHYyNvvgx28IB/VHQ7cVfcTtIcXytlKlBf1FrutULgT8cnY7I063Ri47XeQiUExY6oXA7yuhAwDWibRD5k8b6nm8LlFIZRpGRBs8WCgZTErkwf+WOu1rKeKCn7+RAGaRVU+U06avCRVMLd/BNHsG38L/gxM0af3kV76yqA/fX6w8VLXj2asKVkdH3FmLZIzhUMbKDHvX46TBeYCivaGtT8eYimNEnDK7T+JTCC2IOGDxy+SlFRpq7guQecZGat2wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:34:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:34:19 +0000
Message-ID: <8a261418-17ca-405f-b340-7e6634c169bc@suse.com>
Date:   Thu, 10 Aug 2023 19:34:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Add new VID/PID 0489/e102 for
 MT7922
Content-Language: en-US
To:     Chris Lu <chris.lu@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Von Dentz <luiz.dentz@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Aaron Hou <aaron.hou@mediatek.com>,
        Steve Lee <steve.lee@mediatek.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20230707062959.30371-1-chris.lu@mediatek.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20230707062959.30371-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0055.ausprd01.prod.outlook.com
 (2603:10c6:201:30::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 180e03f3-39ce-4386-432c-08db9995bc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e61kR+eDmN7XBjPLFA3hhtRcL8tPSfMKTOf+Bnsj++74Nkcll9LJNh9aNX0yIsO+0hNnOvuMWRfVRIvLs/KI3z+c2iG9igX7HQhw0DhturfxCE8Wu2+sFc1I5PqEToReyQrv6QmYRRQl4kWMpj+eKJRXJ+vWaPUcSP/XhOmUitxNYrHxcRVsTH/9iytdQgPyoTi3ogKjjciDiGU4aiMH78cLWE7soge9D7OByoM84QG3oEqULgPRBx3P1JgaEdYCk3n5vp4yiR0Ie8Qcn/G7evKgmz3T+W2Fomx6YJzdWJJ7/fOH00Jigfigy7lzNasTT3zfQxrbOTx4kmyi1B+HwZOWFgIc1MEWCAciTl47TWzvQp/Z4tWy/+9uvVSgNGLh8wTCFi6WebQZmR7fVgDI/6SpnYstPRQZYDwVbjGWhV0PK/k1XRvpnPoYkt5ivyvxxi2Adcu4W1jpzJI9LtcySbuAkPEUUJSKARs0FgTcBUaW2CgIyb/HuiHJZjXPVYmU80ihfVIW5ZBJQoMJPhdPpXxLAltS+/4n4qzXsoE4YKCV5RrQijJqFbuFt7vcUgU8PNP9tZSbzuI6gCSsfHKzy/xM1Jv36G5hF6DFBj21gnjE/rA/UGmoEqhiBuRSYduWDNyQekPgynD1ppfokkH09A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(186006)(1800799006)(451199021)(6666004)(6512007)(6486002)(36756003)(2616005)(83380400001)(6506007)(53546011)(4326008)(38100700002)(31686004)(7416002)(5660300002)(54906003)(86362001)(41300700001)(110136005)(8676002)(8936002)(31696002)(316002)(66946007)(66556008)(66476007)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1QQzYzMVp3N0JMdmdoVHFjSU9QeEJDeDJUWEZYR1dVRHc0ODRrVmZFSUQr?=
 =?utf-8?B?VzBhNkxOdFRtVWg0azhCeGVJMU1lT1JuWGQ3S3doWkpWREVVRHRUUEZ4UnZq?=
 =?utf-8?B?N2lWdzg2dkc4K2cvcllkR0JRWFJtd3c3ZEZwaFNSczhNU3crNDkvOW9IeXRp?=
 =?utf-8?B?QVFjT0krMldVdkdxNFlra1BPeDJJMFh2dkxLZ3dtRUlaMDhFRW9OQXJjWGFP?=
 =?utf-8?B?ZkhHOXVPcFBUWWppaXkvRFI1UjdVL09sdldtckx5L29vZkJmM1FnRCtGNWNv?=
 =?utf-8?B?YWI2YWlQT3RWT3lpSGJkYmFyaUtnUWFwK1hyRFFXMHFLclFKMVdTazBXTFlE?=
 =?utf-8?B?T0NvYXN6QXAxWGRETUJ2b0RINE14YmVxeWJ2OGFCNXZSZHhVNnBlUWtnSENi?=
 =?utf-8?B?NytJaldoN0lNdm8reTlSK3IrSXJIL25xV1lXYXpVbGx4VjY0clFhNUIzTnY5?=
 =?utf-8?B?d243MzZyeGwrbHhlaE90dmo3UEpWZU5VajFuRnRFQ0w1bVRTcUdiU216RnFl?=
 =?utf-8?B?NzFFc3I5T2lLTnNvSitJeVM5cDdDL0VNOU1rcUxna2YyOWpXVnlwMHhDYlNv?=
 =?utf-8?B?K29YeDVML2JoWno0a1ZYUnVNQWRlOGJPNEtmQ25QeEx6NFpVTTBjUkZxOFpn?=
 =?utf-8?B?VjExMG5TenJ1MTVJT0tvajZZYlZLNk5FM1JMOHVqS1hneFhHUlRyWjdWVzBD?=
 =?utf-8?B?VHRsZHhpcTR1ZmZZaFE3WHA3S0FPOGRycXF3SS9VZUpDZnNadEQ3Rng4M2Nm?=
 =?utf-8?B?VUhESEJMY2lVMDVCNms4SFJaZEo0WG9lS1Z3YXhaUU8wK2E5NGk0bnlQeGdv?=
 =?utf-8?B?UkpSRlowbnUzQktlQU82ZEY5UWg1eVNXSXRQSGFiM2NlVXMxaEdRY2IwbjFY?=
 =?utf-8?B?NXZYTWVzZXdwT0dqRFlOaW5ldFZhMjkvNXljS3hnVW5HQkV1S0hDNEF2TVE0?=
 =?utf-8?B?b0pnTktXc3NkVTRaakcxeFZFMGM5Z3pTY0VrejUycUZVVlhGUTZteERRaTJk?=
 =?utf-8?B?SHRLYVczWDdFOHlyVTJEY3N0RGEvSk1lZWUyZmFGd0lkT1JMRnpCb2hMdFdQ?=
 =?utf-8?B?Wks1RkNXRHdqdGtTZ0RjMCtQOVRJb0VlVnNIK1ZKakNEU0ZKUEJkZEpxZ0FP?=
 =?utf-8?B?bTNJM1A4b25DdU9zY2hzUHlHb3R3LzIySUNYNTdOMVVITFRlU0RQTjFiV0da?=
 =?utf-8?B?ZHRCY0xlTXpEWlE4bVhwWTdXZEM3OWRBS1RaRGJJdDlZT1crbVBNQUJMYlh5?=
 =?utf-8?B?dVZ3ZlQvcld4MHhyWHl6NWRIT3hYZjhCUEtEeHU1ZkZZckRZZWoxVjQ4ajEz?=
 =?utf-8?B?SXVPWEZ6Y1k0VEt2QmNseUNNbUQ3dU95enBnNVJnWDdZVTY2Z2VjVzJ1WmZ4?=
 =?utf-8?B?TVhnaG1oc0x6aHBOM2F6aHVjTFdIVWo1cTNvTkFzZEdMVXA1MzlOOHBHeXFU?=
 =?utf-8?B?UnVoOFNmUkh0bGhSbm5OcHlwbk9mZCtLNDdmaGoyZFhqeEJiK0M4Zzc3NkxM?=
 =?utf-8?B?RVRvek9mbld6QXArM0tNMEYwQWpJN2RHeGY0V1JvMFZzMlQxYVNmTWo3amp4?=
 =?utf-8?B?cTVkQlNndlJnT2VTQXI3eXFtRzF3UEVva3VZNzc1R2tLRHQxV3hESXhQeE9j?=
 =?utf-8?B?Ykd0b053NEN1dVJLTVBnZ1ZNVEpheHdqZmJDK2lEaFltcHJLR2Myd3c2YVVh?=
 =?utf-8?B?VWQwZnVZSEl1aWRwZTdBWTFXbldlYTZTVy85eHI3UWRDTjNBZXVxMXBGcG4v?=
 =?utf-8?B?TnFvcnpZejF1UXJFSE9OTENLWmhDd0x0ejM1b2FPSXhjaGZxcjR5TllVRStM?=
 =?utf-8?B?SUpUNnh0dkVDd2VvVW8xSTV4enpneDd5N2ZyZVlMYzhML0tzcDZzZE9adE1r?=
 =?utf-8?B?SE80OEJGanBUN21vSVN1bk42Y1FsakljWDY4SlNtaHNhb28yWVBIWXJ1a3pm?=
 =?utf-8?B?RnFuRWszMUtvUE84ZUNpY2ZmTDVLaDFkN3VCeXlDUUpqbVU3ZGNBZ1QzSXlx?=
 =?utf-8?B?bEZDeGwweHN0bEhmeXc2VEVyYTZ4NkZTL292aVd6ZHpUdVRJQTZEaHQ4UGVp?=
 =?utf-8?B?SWhXUTFXZTR0NXRHWmlQb0JwMERGbFdYWkROaFdUbVpsblVCSkhSRTJzRGxK?=
 =?utf-8?Q?To5HUae3qnv5lvzrqFwHhqY8V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e03f3-39ce-4386-432c-08db9995bc21
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:34:19.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YnZ7B58LoOc29DLGQN/FfbT705tnkaGwqgh6Q2Aa5W0RwEQbTTjyVqYFqkJp2f8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/7 14:29, Chris Lu wrote:
> Add VID 0489 & PID e102 for MediaTek MT7922 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e102 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
> v2: update commit message
> v3: fix bot checking error, change title

Hi Chris, mind to add this patch to v6.4.x stable?

Or end users need to wait for v6.6 to get bluetooth support on laptops 
like ASUS G14.

Thanks,
Qu
> ---
>   drivers/bluetooth/btusb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c7411557e491..9c886c9cce64 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -635,6 +635,9 @@ static const struct usb_device_id blacklist_table[] = {
>   	{ USB_DEVICE(0x0489, 0xe0f6), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
>   
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
