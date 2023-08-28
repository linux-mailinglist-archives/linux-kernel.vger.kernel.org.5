Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92178B3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjH1OwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjH1OwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:52:11 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE1DA;
        Mon, 28 Aug 2023 07:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwHE95zrbccJXyyG4XzBS58asl6Tv2pKnFnN5WmMb2N167caMnvaQF1GSPVYxlY99fSXLksT89P5BNk/MLEKc7Ir34TKSNmxT6GMtL3rvdCNpltpCHFQJJn7Zbp99Jo3XKmMUpW0viv7gIKqDNpeQGyiIlMHhX0CtgjszLUrCCEwYxm2Qeyy+LaB4gj4RQ2oAWojsw9iseCCA624LKXjEWgE35dXNbaB0ZKcQ6StRwVscFAzcNxxVZYZr60plzaS5pBavmZ8Tf0/pA0EqTQ7m8MVd3mC/mbxeFW9PhOoj8MclWLRwRK4RwvzM+z1hRsEW662UVxJ2g0ItoqmVUUdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WYzLnY5ede/nx197Hmb55LWvYmk62JtcNmoIrLiyvs=;
 b=QOtW41ZHls6SI5m0Uwt7jPa9qa0bHRnamek5CItbpeLno9PwQSERcfA0biqfgbBn8amPIL6CmDOkS+orm3WNgk5rwhFSweNA9siL61OmISEygLIocQafloDymUp6QkKphowEVlo1diULlEyeygbWznJ4yneZz9REDsD8Tsj8ixYHkyM7bvmSkrLBKXJQT2JL/AkJwo7W5kyHVplE/2N5QScUcCOOYj03bGxjKO3gIq5G7gP+rh/azXGC81Ms/lrJhlirYFpcMq8ENETLBNsyEx9R30J6jen80LPwtCtGBwoiv8sZbHmPmzW705/B5QG/tCcwWUOQHBwn3guM9mPJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WYzLnY5ede/nx197Hmb55LWvYmk62JtcNmoIrLiyvs=;
 b=NrindBPqnWHRP1mtD8doz0vEiE+nrXwGkB8g/q4oWcESktNygbAVDb41rCErz+rXoPn9ujsKFGluWTd3A6GzKwVQrY9yzGaDkfbVgQceXRpbSJxXz45xseZZzg2qnedb+imbdJzKwAX8lV7Z7MaSOa1viWR8pE2mjSt3HPwpADk+wJ0bu63akG4UDCDVSxmW4N5MfudCvt5/qYW3BLSogIh9o8W2YR8A4eoRf9Q/zJSjdBqNUHALmz16dlyk+YGlrUULFvwbcOjUiQyIxZxwcIJkgbMr1eO8h2CIFDQYi+SddwhTepyNiJhW0zqpC1BVrsbLs+2xJR/cdauOVyU15g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:52:04 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:52:03 +0000
Message-ID: <04e8de7a-55e3-4d12-921d-537750fe6217@suse.com>
Date:   Mon, 28 Aug 2023 17:52:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [RESEND] USB PD broken on Lenovo P15gen2
Content-Language: en-US
References: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
To:     heikki.krogerus@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Anthony Iliopoulos <ailiopoulos@suse.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
X-Forwarded-Message-Id: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 922e5455-1423-4ee5-e2d7-08dba7d657a2
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qR374TSiCobj4y27+sVR0hv55WXIv/oqMJb5AvCUzo989Uy24JkJ6EWMqlIm3ReM3b0eTzeccCJf8xSFwx4rZjxvTE7VauQSujINxKZeUquQpYZ57WiWaHSpm4gKV52wdBcaIifjo79gaAzNcreoiavUJ0ANAgBCIR7Qi4Ttjjv+UGinfC+42EcCNoFpjcgm6kxyfNJfJoV9K3Q+x9+vt9Z6f20G557zkgVWJ4/MwFNKbKPAwgS3MzcMhmN4F0L34Ng0gW24znuQKbKzXwLh7Dljcad3tqB3sSYnNhIpxM8yPoMhwMt8HGR7oyOo3LDXdBm+FQ+SIXx5VxkoT1ZSdfwuo5tSHGw3bTDDb07/yj7gZgfWBUF0YWKwAjFL1q/64xqleEQRh/BkvGKBlb26mZoxma4DRmxRyiZtW7ND/tTp8FAxkUPJkRW+dN6LUSqJetyoX422SqaCJx1eWJsBEBsDmr0qMzw/NXjN46rOU6JAR/d4qJ/a4fN0cBZga7WN0MMjAHTbSZH+r7DIxqjrJtyrumz8R9lbTiPlBdsr+3PcuHKWBZ0LrniLrSob7pgghSOIdftbJHuzGHw8ulJeuDbWi49TwbEOdtiBYXlEnXtnQt4Y0LmjiQ/uFErS/BnD4DYA7yHlFjJGBONN1CyTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(107886003)(2616005)(36756003)(26005)(86362001)(478600001)(8936002)(8676002)(110136005)(6512007)(6486002)(6506007)(66476007)(66556008)(66946007)(31686004)(316002)(41300700001)(4326008)(5660300002)(2906002)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFHWkd6ejNSSFVkaVNlSFhaNnBtejQvT29qQkU4MzFLMHM1K3plS0l3cVZP?=
 =?utf-8?B?MmVRL0xXZzhLSWVpeUx3WFJpbkRNdFVJZlFaUHFvckZsV053QWR0UVFrRndJ?=
 =?utf-8?B?Y1kxbkVrOTRYQ0xlb3d2TmlKbis2TEJGclRieXVvbUJpeWJXVzIyU3pBbUJM?=
 =?utf-8?B?Qk10ZnVIMk5vSTRRZ0tqcENYVWozYU5UejMvU0VYRzB6cVNIU1lSQ0xPdy9i?=
 =?utf-8?B?cndQZmtiUTRrT2RPWUlvRXJuWGtPK0NNZ3FCL2tyOGFtbElWcENJNUxNYVBN?=
 =?utf-8?B?cFU2LzRMcGhHaHFVV3h3dGZGaGpyajdoS2g4Zk9DVjVRbjBzQ3lXZjN4c1Jr?=
 =?utf-8?B?QlZZWTNaRG1ZbmVKanUvcU9MRktFRkl6Ti9wWENBUEYzV3hOTGNJSWJsbkxK?=
 =?utf-8?B?RHZBTDBmbEl4RS85SkZKVStsZGYyZjFOQ1JUczZxSytEWTZxSVJnbUVub2x5?=
 =?utf-8?B?cmk3UVdxeWhKQXV6UVpDTi8zbUtVMFhWcVRMNkJaM1prYTUyeExoRUx1QjYv?=
 =?utf-8?B?UmVTM0cvSjgrem9SRUxYSzNkcGljaGRkR1RpRW1WVmJ4NmZKSzJvQlpvZVJX?=
 =?utf-8?B?a25nOUYxQkhnbm9WYmp2QUdkWmhpTTJ3eWVXSEtrZGVjdlBmbmxnZTFNUzc4?=
 =?utf-8?B?NERncXFYVStINnQ0Nm43c2FNa2MvT0k5cCtBSEN6K2NicUNqdFhNOXBqS0ww?=
 =?utf-8?B?R2JwcXU4eWRSb0ZpRE5vN0VJOGt5MmYyblNHcVVtUDEvZncwaWFFWHFQSHRN?=
 =?utf-8?B?cmJLSHlHeHlFWE53b1IwU1VUVVdFZjYzdWpSMnR5Rklxd3dmbG5ycUs1M0tq?=
 =?utf-8?B?am9VdFFJd2hqVXpUcFluVEhGQjMweGNKeGwrR3c0NEVuTUI4TWVBUmp6SjJB?=
 =?utf-8?B?SXAvd3RKbXZFY1RERW1ZT1Z4RXJTdnZyRHJHNGNJdFR0SEFLVlFGaW5DelpB?=
 =?utf-8?B?VE5MdFowY2Nac2t2bm1tNmdSencwWjg0VkFkKzdxdk9pVjRFOTgxcDllT0JL?=
 =?utf-8?B?YTdGUzlLN2pGZTJMbWNmcUJwc0ppeUVaWEJyazdZS1VsWEJwbGdNZm9LNHhv?=
 =?utf-8?B?VktSbDNZQlU2TWxralJVQkJETllEVU5aN1lwRTRnWFRtZjcvQnV5ZGZPZDBV?=
 =?utf-8?B?MDVYWGZvRTQ5WTdCTGtSUkNkRGdHV1dOVGJrdWJ1MmxSR0o5YllVcUFQQjRm?=
 =?utf-8?B?TWt0b3FsNVlRUjk4Zks5clY3bHBTSEJtRVpSL3l5bVMzQThrZTJBUmtsSmN4?=
 =?utf-8?B?Z1NUR0JnNERhS3Exa0xUNDhJRE5yM3p2MlU4UzNPVmJEMWpEZmpjNFNTaVZI?=
 =?utf-8?B?Z2hWdGZSWm5FUGFZQnliN3laejZMSUFOdERkTTBDZFh3QUlZRk13Ync5MTcw?=
 =?utf-8?B?QjVJbVBHUHhFbFVVRCtUclJ6bE9JeEsyQ1pHUjV1OTF0R3gxS1g1RkFmU0ZS?=
 =?utf-8?B?S0x3ZUE4dVlhOWx4Qm9DUElvMmNLcHRkQUVFN1dLOHNwZVN6MVNlYTNMQ1hC?=
 =?utf-8?B?aWFDMEY2djZncEFzYWlNNFZKNFVxUTVGMFVJSXdESDNwZ1F5UE9xUS9PSWMw?=
 =?utf-8?B?WUVnYUtDQ1FDQXl0T1FNS1VOV1QrNDFtdkpzR2YzYzB0Wk5UeUhGRjNHcGRD?=
 =?utf-8?B?R1VPemJ2VWhTSjI1cmkxb1R2M2tQeE9BeHRjK1d3SFVxVmNkT283TjFURHIx?=
 =?utf-8?B?bkxnditKVmliNDBPazk3UG43LytSWGxEeEkwMFpPRUE1cnE1SVlPWjFaOVN3?=
 =?utf-8?B?M3QrbEFSQkI1MFdRWG50b1J5bUJmOHFiVTFMNzdJeUp4dEhpU1YzVlRObnpt?=
 =?utf-8?B?ZUJFMkM0ZTI4VjZ1VmtndG9heVNkWVRLNWlMdkcvOG9yQVlSNWVwZitsYUdR?=
 =?utf-8?B?STMzSEp0T3d6QlVMcWZmc1o0ZG9oa3lFWG5TcW4yU1hacitPV2ZIUjh6dWtj?=
 =?utf-8?B?cmJvL2syanlZTlJoNStndHpHdHdGZ1lzZXViUUxEbXdjU29oREdsbkZjeVpv?=
 =?utf-8?B?TExvbHBsTHQ1bjcwNU85Y1ZpMDdSOFN6WTFaWElKVGx5WHVtNHpDVWl6QXQ0?=
 =?utf-8?B?ejN4WFM5SDdiS1pYN3Vxa2F0eElqSTVCd2dJQU9MV0ZoajhRemQ5WXliMWZm?=
 =?utf-8?Q?F5CElwr/uj/OfH86pE7eXN2jJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e5455-1423-4ee5-e2d7-08dba7d657a2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:52:03.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCvKruJ0XX3MkDaV6VhMw3K5yvRRH1KpmbDLskIx2WE05LGbYHXPR/LYhqnJ7rZ1Kn2RoppdUzrD2YgSlzfuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Resending as I had initially attached  a full acpi dump and it got 
bounced from the usb mailing list]

Hello,

I'm not able to use usb PD on a Lenovo Thinkpad P15gen2 laptop. It's 
equipped with 2 thunderbolt ports and a usb 3.2 gen2 usb port, all of 
which are supposed to support PD 2.0:

cat /sys/class/typec/port*/usb_power_delivery_revision
2.0
2.0
2.0


Whenever I connect a pd-capable device (i.e a mobile phone or a tablet) 
with a known good cable i.e i'm able to achieve fast charging (~30w) on 
the device when using the same cable but connected to an external 
monitor and not the laptop, I'm not able to get fast charge to work. In 
dmesg I get the following:

[ 1262.933106] usb 3-12: new high-speed USB device number 8 using xhci_hcd
[ 1263.083343] usb 3-12: New USB device found, idVendor=22d9, 
idProduct=2046, bcdDevice= 2.23
[ 1263.083350] usb 3-12: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 1263.083353] usb 3-12: Product: IV2201
[ 1263.083355] usb 3-12: Manufacturer: OnePlus
[ 1263.083356] usb 3-12: SerialNumber: xxxxxxx
[ 1263.116184] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-95)
[ 1268.676590] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-95)
[ 1273.816117] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-95)
[ 1273.904187] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-95)

When looking at the state of the partner device:
$ cat /sys/class/typec/port2-partner/supports_usb_power_delivery
yes

$ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
0.0


After some debugging it seems this is because the lenovo is not 
supporting CCI which seems to be some sort of a communication mechanism. 
This was asserted with the following bpftrace script:

bpftrace -e 'kretprobe:ucsi_acpi_read { printf("ucsi_acpi_read returned: 
%d\n", retval); } kretprobe:ucsi_exec_command { 
printf("ucsi_exec_command returned: %d\n", retval); }'

Attaching 2 probes...
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: 9
ucsi_acpi_read returned: 0
ucsi_exec_command returned: 9
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: 9
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: -95
ucsi_exec_command returned: -110
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: -95
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: -95
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: -95
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0
ucsi_exec_command returned: 0
ucsi_acpi_read returned: 0
ucsi_acpi_read returned: 0

This would correspond to the following snippet in ucsi_exec_command:

if (cci & UCSI_CCI_NOT_SUPPORTED)
              return -EOPNOTSUPP;


I can provide a full acpidump if need be. And I'm also using the latest 
available firmware from Lenovo, installed via lvfs. This issue happens 
on kernel 6.2 based ubuntu kernel as well as on upstream 6.4.3 but it 
seems it's not dependent on the kernel version as it's somehow related 
to lenovo's firmware.

I'm wondering whether a similar quirk like the one for the zenbook is 
also required for lenovo ?
