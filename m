Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6978BCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjH2CnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjH2Cmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:42:49 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBC11B;
        Mon, 28 Aug 2023 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2428; q=dns/txt; s=iport;
  t=1693276964; x=1694486564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DjK0BkwdKz/VJmS9YmIW0g0j297ltxnDcweQy7EIxPo=;
  b=DMogzIMxdRJaPHrnDyWKH79GUAiMHgUaYfuTIZ0iUGOjeEe1J2iyIcgE
   2tFcrm2ZtoTSv40hugbXAU0EaNvlj9AcqRPCugroFl76/z2r2UDnH63s6
   HQ0vF4XNCwuPYwV6c6JApGmCE/lhPNbJBOPwvNsgNm896hCmB+XByx0Nv
   A=;
X-IPAS-Result: =?us-ascii?q?A0BPAAAnWu1kmJtdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ0WyoSRzGHbAOETl+IYgOYIoVaFIERA1YPAQEBDQEBRAQBA?=
 =?us-ascii?q?YUGAkoBBAEIhhECJTQJDgECAgIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUA?=
 =?us-ascii?q?QEBAQEBAQEeGQUOECeFaA0IAQ4QgX2DYAEBAQEDEhUTBgEBNwELBAIBCBEEA?=
 =?us-ascii?q?QEeARAyHQgCBAENBQgaglyCXwMBnnQBgUACiiZ4gQEzgQGCCQEBBgQFsmwJg?=
 =?us-ascii?q?UMBiAUBiX0nG4INgViCaD6CYgKBRxuEEoIuiW6FRwcygimDXoh4KoEICF6Bb?=
 =?us-ascii?q?D0CDVULC2OBFVE5gT0CAhE6E1BxGwMHA4ECECsHBDIbBwYJFy0lBlEELSQJE?=
 =?us-ascii?q?xJABIFxgVMKgQU/EQ4RgkwrNjYZS4JmCRUMNARKdhArBBQYgRQEbAUaFR43E?=
 =?us-ascii?q?RIZDQMIeB0CESM8AwUDBDYKFQ0LIQUUQwNIBksLAwIcBQMDBIE3BQ8fAhAaG?=
 =?us-ascii?q?QNEHUADC209NQYOGwUEZlkFoCqCUYEOHDJ2ZZMNNJJknwoKhAuhOhepXi6HQ?=
 =?us-ascii?q?ZA9IKJSLRmEYwIEAgQFAg4BAQaBYzqBW3AVO4JnUhkPjiAMDQkVgz2PPAE8d?=
 =?us-ascii?q?gI5AgcLAQEDCYkJC4I0AQE?=
IronPort-PHdr: A9a23:1QTYvBVTJuBtgTg4jNj/YC8FP+zV8K0yAWYlg6HPw5pUeailupP6M
 1OauLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2se+zfyz/5TQSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:+U0X0a/lv9BtS4KLYZmmDrUDl36TJUtcMsCJ2f8bNWPcYEJGY0x3n
 DFLCGGHaK7fM2SgKo0lOo+39kxXsZbdxoNiTFZsr3tEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEjmE4E3F3oHJ9RGQ74nQLlbHILCCYnoZqTNMEn970kozwb5h3uaEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8kFWc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO6VoD66iWuqBDe3Y5gbvUsSH9VlAmYtPwvj
 9tGlLK8SioAa/ikdOQ1C3G0EglkNqFAvbTAO3X67YqYzlbNdD3nxPAG4EMeZNJDvL0oRzAVs
 6VFdVjhbTjb7w6y6LGyUPVtgs0gBMLqJ4gY/HpnyFk1CN5/GcCaHPyRu44wMDEYvttFAu77S
 ucgZBlmNA/caBAeOGoaB8dr9AuvriCvL2IHwL6PnoIz4m7O3Ely3aLrPd79ZNOHX4NWk1yeq
 2aA+H72ajkeNdqC2X+e+WmtrvHAkDm9W48IErC8sPlwjzWuKnc7EhYaUx6wpuO0zxL4UNNEI
 EtS8S0rxUQvyKC1ZoKnUC2ZmHybgg83d4QXHeYbxg2O54OBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7eb9pZW1q+n8kN+iBcQGBTRdOnJcHGPp9/Gm8d5j1EueJjp2OPft1oWdJN3m/
 9ydQMEDa1g7l8UH0eCw+krKxm7qrZnSRQlz7QLSNo5E0u+bTND+D2BLwQGLhRqlEGp/ZgLa1
 JTjs5PPhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOsWokeBg1aZZVJGGBj
 KrvVeV5uc870JyCM/cfXm5NI5hCIVXITI68DamEMrKinLAoL1XZlM2RWaJg9zm9zBdz+U3OE
 Zyaas2rRW0LErhqySHeegvu+eFD+8zK/kuKHcqT503+idK2PSfJIZ9bawHmRr5is8u5TPD9r
 ow32z2ikUsPCYUTo0D/rOYuELz9BSNiXMyn+pQKKr7rz8gPMDhJNsI9CIgJIuRNt69UjezPu
 Hq6XydlJJDX3hUr9S3ihqhfVY7S
IronPort-HdrOrdr: A9a23:7NOqhKrCWvOx6jc8ff4O0t8aV5tuLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV7QZniXhILOFvAt0WKC+UyuJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjHzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiY8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aKSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXAH4ot69Mdkmynimg0dVeJHoe
 R2NqWixsNq5Cb77WDADh7zJklXfwSP0CEfeKUo/g9iuMMlGc1sRMokjQNo+FNqJlOm1Gjhe9
 MeVv309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: 9a23:wCJnum9tnBSlUXqTRa+VvxVOFfAESn/C8Gb7DxH/B21IZrGWZHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AtuAu/A2349EDuJ4n/JbU7ef4SjUj27+lF1govLg?=
 =?us-ascii?q?/tuqNbTdsMDrMjgm6Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 02:42:43 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 37T2ghvK020181
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 02:42:43 GMT
X-CSE-ConnectionGUID: B5mLfbWRQbCAryZL+vAy+Q==
X-CSE-MsgGUID: h5HqMvNzRhWM39/g3PazDA==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,208,1688428800"; 
   d="scan'208";a="995434"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 02:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwFXvlLN4Zo3lmOFPVdgKLq9RW2qc+vJIJv86lDqk19Ltqwvl1U0wyirwu3jD9dLdX3jB4DmZj8Q+eURXI15lemCNASjjDWgQ25fgowkk5fANXqWNVsY8kuRvbXKCCjKuq9AbFNXI/JXea/xNxHCE8At8RQFmGw8Gv0iXOVc4UoI+FWH0LneCJ8lDsgcPhDsYvc5trghXVmq2BMFNpBS48pDklBI5Qnk7BRkWj6+nc9fodVtyUYdGTIuT/RUWVcdUyk2mYdaaQkjtQ/DHUbirzkh1kqWzwjS+s1nQl34sQyCT0OuWJm1odFdBwUH8kZb8QBURwvWSLbUWMdC6Z4+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9DpMnBOvWSkHag0ZHXrPOtx3PHoGCn56+dungQPNOY=;
 b=go7WdSHb6iRy0162+fEzNrnuClnZ2Gmuw/pF/HqaeORR4zjaeHsu4Y9UgyDBJA85F7DaaM0aGCBYkdeT+lXAjHfXN7F79BCTZvBHbOuteqTkrpMKONYQVh/JflDBTkr/wrHoBnQISslw8bn9ShhfZjzir8IuMyKK14qjaN8Yd01L9oLzGJCIcf59NkCIwl9+GuRMaF2EH9avzC6EAV5PLC2ltGy/7khBBDdlUOZT8xmfA2KTS/ypt8NL+NBG61OhD9I/AW/64VoKbLb5NoNq+b5Uq7o1WoOvGW/NkvtrRGo8EgZTdxTog8N1ni3h8lDE5rt09Z00XV/IPf44BEK6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9DpMnBOvWSkHag0ZHXrPOtx3PHoGCn56+dungQPNOY=;
 b=EQFAF5lvo8RIRkkBq6lG4NAalJesAm7WenwAdZVWaq/EqQtX/+CBnusd009oXHdQtezmFxZCDSHR/hwrX5dN43bQ+gZ/Bxsvxl/YNPUtygQTPYlIfJAJMlpr41l0w4VK2Hx1iscHwQpT7s6B1aZb06XTfp3boEbHk27SlnJqmWU=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 02:42:40 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::9ea9:5b30:8472:bae4]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::9ea9:5b30:8472:bae4%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 02:42:39 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] scsi: fnic: Remove unused function
 fnic_scsi_host_start/end_tag()
Thread-Topic: [PATCH -next] scsi: fnic: Remove unused function
 fnic_scsi_host_start/end_tag()
Thread-Index: AQHZ2hSBP1Ir378TfUGKL54nTY6QpLAAkFjA
Date:   Tue, 29 Aug 2023 02:42:39 +0000
Message-ID: <SJ0PR11MB5896A6F3DB8872392D4A918EC3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20230829010222.33393-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230829010222.33393-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH7PR11MB7050:EE_
x-ms-office365-filtering-correlation-id: 80ae292b-7492-4d8e-efe0-08dba8399cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q96VOCbqM0KYs+uZ+W4sy/L9P9ryaaKODrO+lsyaW036kOeD3aunoyLcrInkQcEBMajDKDpuuY6TVnipDiL/hQByCwuuaqxosS6dwiSgCWLe1V2oJkTMs9tzDALi6Z3/QMXEXI7DpxqNdTcogie/ts/vi0VmvL4FbY3FPUAtZT7wzYHYUCkTResXHi9PUwbmwtoyhaEdrhlR50TVy7CsEgAlbGolGLtAipjqiFXITyDIDkS4aVtxA/9o30LdwEUgpVaXTAqcd06EemHpfbn9DkJ//xnstbMlrI5CxqbntvDAL/awB4aEmkOOYP761GGbDavk73wQ3hCXWAFIV82JGlmzDKEybGgOxyPUQ8HiQit+IJqkXlsxt+cNBXBrFIbcV3SaFYYWsimaSbATCdplg2SWbk70+D3kWxVjVS/PhLZ2wpU5UQBHnm3xT+w/Gju2AnGfPRa7qwK5acAD5LDlbrmx2LkLC2RWjfxe1fcq+TZh/+RQZG0VjW6d5b5KmdNs/ArDCEfPIH8w+ZcEpnWO47TdB+jQOIrgVjjogT+A/J+CaXoMnmTZqO5ObX7uBINpiZJJCIHFFhH/+U7BHXhjavRZVQAMxWpfNtaJa7kooyZXgEwtEM2gyv4iSlcXsdTg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(9686003)(71200400001)(6506007)(7696005)(55016003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(2906002)(83380400001)(53546011)(478600001)(110136005)(41300700001)(54906003)(66476007)(66556008)(52536014)(66946007)(8936002)(8676002)(4326008)(76116006)(5660300002)(6636002)(66446008)(64756008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Jyzk/g9Td/Txm/kodgrF23klv7IBTcU9MCniJBWZQX1Dr7P4DSgLE6q3oAj?=
 =?us-ascii?Q?o45mLZl6NmQgNFSOxAM/0VM2fBlmChEAXHFPiETwIJOzmds7jGCmoa4P8L6M?=
 =?us-ascii?Q?upGsLagX/47GZHkxdou/LBjfuiSo/KbjsbybjhotrufW0g1Nv3ag3HKc6q20?=
 =?us-ascii?Q?vkMp2Jl1MHC3DqIK3K5FNT4wFxJC0ud8lFzti1oMbEE5PJBRd8IVGeLQcvoh?=
 =?us-ascii?Q?h5/m0oIxzRzYMPoDzqkc8wIZh929jnkjUoU5k/u/7feZLvQ4eZ4+szDIuKSU?=
 =?us-ascii?Q?+Gv2CW6X7bofPbpTMY7k5+uwYDR0OPYJFYCpq8LO1cmYT5jWV564jwfijIfi?=
 =?us-ascii?Q?i+pZ1B/1KM1B6gjuJXNeEtRWVSUW0SVYWHnx5A7q6JGI2HFLk0aIezU9GoSE?=
 =?us-ascii?Q?endOLDlXMM/5aSJPCjfFJ+h2R3e1i66QPvLRUPf01uceELGA+8bCPGgsgUwf?=
 =?us-ascii?Q?4sOeFQhCyODM35bntrvb3RQ0NhkTmVPkPk+lYVNaA4QQe5KVydT+DHmrkatf?=
 =?us-ascii?Q?wuEC1sHIIVo024loclBmYdJonwcYMM6Ey4NYL0ZpKTFOud67jf8aJvVwoFER?=
 =?us-ascii?Q?ckxr98jzCXzPA1da0Cty4+0V2kUO9ah/nO4gne/wcQuxaWUYjRrKzx8+Udhz?=
 =?us-ascii?Q?rBMFYqIODhqP5Jp9kAXFXdkjjqWtISJPn4JTZ23c8aCy5xP7gavwhSFBhOHu?=
 =?us-ascii?Q?sJDueajN20SeJWUGxtGQnyrLt/8deGseHJwrY9DAPZ6nagxVGx6kTUWzAPLt?=
 =?us-ascii?Q?h9W8E6V4b7LBcsY7XcBJ/BVKjEfmVGCwwV79D3eOzTvd9FC8fgw8Mza81mZK?=
 =?us-ascii?Q?uOuC7O9uRbEQOqa8y7Qc3xdsMN7smc5F3cH80IlOELy9hjWBFWVj6onz3WNl?=
 =?us-ascii?Q?IIzDZvJ5tZih/MQj6pSaHUay8bYcmTdQM+Wd1yTZVw+Yw3HNAtuwQGANFtAS?=
 =?us-ascii?Q?D/gIjxnTPp5x8v0iKdsVZWRMP/w8DzpskphUossj06RFAaOB1Yx1l0mLI6jS?=
 =?us-ascii?Q?xkcBE3xwrEaz/Imerw2VabT5lAVDNjcS5kIpGTxw1xkexPR0sQ2U6db5Xgub?=
 =?us-ascii?Q?Iag1jHA58Ffj07z7BKjMOxJxZU636vaIB//k1OBEih+fjDroK3Hjy9TDywwp?=
 =?us-ascii?Q?Q91fQahsya0Nj5szclNg0CbdEmme2rgX2kS0cRDPNksaMp5XMpOYCbPQjXg/?=
 =?us-ascii?Q?9TB80XX+xLyLx5VpX9nM5Dh5Ask4yVlVkPL0XhU2NPjvwFsC8M/LymTPbJRW?=
 =?us-ascii?Q?YSC+qPMNHruZbgqQhIS3KnlOahq6HWJVz37owLNKNFGHDAgPXggaaQ8p8gzP?=
 =?us-ascii?Q?loyAkKze5suWoQG1GL2IZ9thYPz40R356CWuNpDrche74yr+m5wlPizfFXxO?=
 =?us-ascii?Q?W8o+SVMG83SaTZcH/Z/ENnvZr3UhXJnbVVKM0EXCagZ3bGkpOqFfC5FsCgpQ?=
 =?us-ascii?Q?u7zNeqrtzEMKWeVFB6GAPziJ7n8oUgM4G5jIoLYrX3D7N17+IfhvgEd2DwiX?=
 =?us-ascii?Q?VdstUMqepY4DK8PLFX25dgk/rrs1rVcTwEhxUHIEc6gyPGSCm2d2PQrSlFYM?=
 =?us-ascii?Q?YZqOYAm+GD9Cs/V+tP1VPgwNyF76YX0b0797PvMSe07BRTs/eb39ufVkH9tM?=
 =?us-ascii?Q?olPMMPnu0U+gwVbJYt0PreE2MjVykvAdFcp6Si3TMuol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ae292b-7492-4d8e-efe0-08dba8399cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 02:42:39.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nHoOVwb7lO20bLGnH5yBNINF31UGE1R6Xvzg9/YzezJcfrLOGLmgDTR191xZv2NWbZtHW/sUVXun77kcYJvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thanks for the changes. Looks good to me.

Acked-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

-----Original Message-----
From: Yang Li <yang.lee@linux.alibaba.com>=20
Sent: Monday, August 28, 2023 6:02 PM
To: jejb@linux.ibm.com; martin.petersen@oracle.com; Satish Kharat (satishkh=
) <satishkh@cisco.com>; Sesidhar Baddela (sebaddel) <sebaddel@cisco.com>; K=
aran Tilak Kumar (kartilak) <kartilak@cisco.com>
Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Yang Li <yang=
.lee@linux.alibaba.com>
Subject: [PATCH -next] scsi: fnic: Remove unused function fnic_scsi_host_st=
art/end_tag()

The function fnic_scsi_host_start_tag() and fnic_scsi_host_end_tag() are no=
t used anywhere, so remove them.

silence the warnings:
drivers/scsi/fnic/fnic_scsi.c:2175:1: warning: unused function 'fnic_scsi_h=
ost_start_tag'
drivers/scsi/fnic/fnic_scsi.c:2196:1: warning: unused function 'fnic_scsi_h=
ost_end_tag'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c =
index 185142efee3d..9761b2c9db48 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2167,39 +2167,6 @@ static int fnic_clean_pending_aborts(struct fnic *fn=
ic,
 	return ret;
 }
=20
-/*
- * fnic_scsi_host_start_tag
- * Allocates tagid from host's tag list
- **/
-static inline int
-fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc) -{
-	struct request *rq =3D scsi_cmd_to_rq(sc);
-	struct request_queue *q =3D rq->q;
-	struct request *dummy;
-
-	dummy =3D blk_mq_alloc_request(q, REQ_OP_WRITE, BLK_MQ_REQ_NOWAIT);
-	if (IS_ERR(dummy))
-		return SCSI_NO_TAG;
-
-	rq->tag =3D dummy->tag;
-	sc->host_scribble =3D (unsigned char *)dummy;
-
-	return dummy->tag;
-}
-
-/*
- * fnic_scsi_host_end_tag
- * frees tag allocated by fnic_scsi_host_start_tag.
- **/
-static inline void
-fnic_scsi_host_end_tag(struct fnic *fnic, struct scsi_cmnd *sc) -{
-	struct request *dummy =3D (struct request *)sc->host_scribble;
-
-	blk_mq_free_request(dummy);
-}
-
 /*
  * SCSI Eh thread issues a Lun Reset when one or more commands on a LUN
  * fail to get aborted. It calls driver's eh_device_reset with a SCSI comm=
and
--
2.20.1.7.g153144c

