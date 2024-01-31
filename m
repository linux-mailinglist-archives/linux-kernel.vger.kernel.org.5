Return-Path: <linux-kernel+bounces-46889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBC8445DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D21F28A57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423F12F590;
	Wed, 31 Jan 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWWc4stV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qTmpqUoH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A987EF1B;
	Wed, 31 Jan 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721437; cv=fail; b=apbwl0L3c2julzr4xd0/jFAYqSJX2jB8H1RKNQXpKqJjhTueaj3raP1f3dXUyXQ/IPiFOx8pcXgDsNqrsSnoKvLdvjjGY+9P1UzkLk1ozaiUmMHubK1TOB7rN/8HuoG4NlRdi1DhzhDAEhvZj7hGZQhzI+23Q0O4fdpYhYfE4D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721437; c=relaxed/simple;
	bh=o79WXYWCf1O/Xp+nQr2NWQSbrW6uNnbzr+EUQi1tUmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0h2DhYaqhzBZjcMT0uS8F0vvsf0hT/Q4koyNg6SwpQ3kclWqsysU79oVSCg6groKdsLCsLciIIASTC+Kteyc+kSobjJ8tO1fL5AzrqHjGb24CfIjBKwrfGtnhgIa4kQnfUiWQISHQLjaCCvcbIep6gIWesle8h2stKbhI5qXqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWWc4stV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qTmpqUoH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHC3La004776;
	Wed, 31 Jan 2024 17:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z8Er6RlR62k0+TiQ0GTOZZHz1oayRc0REYipSnbL+40=;
 b=cWWc4stVrHZMr4QCPG8gAKYn1tZHZxljVWCalGeTG7adkNLSp18TTiK7RxQm2M6Mvj53
 BXlajyZwdezF4SstLJz9Ss4Um7E8a9JR0O6j0ZkkvGeKrGzrMGHI9CLb7E66m4H1NBjN
 Hwtmpmx7btKC3B74VUOHTCwbEURY9EEDWMhHUmeSyDgMmyYCRufXQJXyoKyxOGMjqrh2
 S38xZWphm1LEK7YSY7DM7x6QjFD7yMQee+FNquGYJEjOkXMLyr6+gzxcHxkfTg5wlDst
 Xb7s02juzJS0jEBblk1Jwlf78UcoO0r1ZY8dWo/FCP2pNP/kBYhHdWGQdbr673RdOKmY MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqb2djr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:16:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGmsFX025933;
	Wed, 31 Jan 2024 17:16:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99dkjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt1ubjM5N2bvrMdCKR/REFJJAE2Sep+PmL7+oz5wncyud27UOgKDB0JS4n53ed79+C+uFe42vFwDEmy2SvIyELZRV/XFP6uJ4m6LnqC/CWttcmujl5RdCakXDomXjc9zf0g5ayTZHxaWgKXyUH3v/XmJuNq3msnF8EVIsmSUI7xwibhMwJZdLURTAFxDSueUrIo1FIb/ygSoeapzotIajjIMBMbNx8nHUSBiR0gH0RDjmydYrcMfuJ+Jo/Di4SB78cja9Yg/uoShg0Svqp5BkjIwJaUsQmn4eU+h3+3C1DfLWW4tnSH0TAnByNZDZP7obNJlln8AAHvtYemA9CJ3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8Er6RlR62k0+TiQ0GTOZZHz1oayRc0REYipSnbL+40=;
 b=J4Q4LCBedoQQieRM4y+d3c4/YAavQSttaB72zo1KVcWEEtjcHP9Oyw+aGoXa7eWJUmOz0vyhzaWdxDbohDuRxckRZymuNDgE0bgaUHbBI5yjny8E8cUAFlshleBoZBwa8aXX+sfWrot3WX+0p2sC9OYokSTOYCHZR2zD9VCWZ2Dk7+gzisEuKSaZu7C2zmv357xuCLwWmgZVRQmswc4Gexol50K5Ea5bC98TBZ+SwlxUxR7X8XxDyIfYoZTyosQZMwMmOysucHcNqxOU4tDly2Ggb1SrudIaX8/s/seVH1NvnZ/BWs2hPmW8IJVKgqG8R2XafIlzJardD6OVqxJErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8Er6RlR62k0+TiQ0GTOZZHz1oayRc0REYipSnbL+40=;
 b=qTmpqUoHBRtyL3kgTsnlzOy9ThE9gzcf7I2zOjvLDJUw3wSfqRa6zshaGwyRMSuXTEt1EQz3k4R643Xgm1pDfEQzjHUnDHQhN0gnm9jeni5zFfg5bnsQFykY1bbyFhL464LAhb86/QQ7x0ULtAZSvvlDzAoFrzc7E1Tca4Lko8E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 17:16:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 17:16:14 +0000
Message-ID: <e21c6dbb-7083-4425-bace-6194bfbf35b7@oracle.com>
Date: Wed, 31 Jan 2024 17:16:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
        nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <2024013158-dipper-mural-424b@gregkh>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2024013158-dipper-mural-424b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 144eb20c-0985-436f-a84d-08dc22805425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IuWz4qDvpHZK8TjQXMU5A4Lc+28/hANLYD/YS9ck70LBkUpMFtJod2euRfG8VrWxV3svkBbrADPkuIvB9l0N6D4OhGUZJM7lqXJhlA5gpX1EeF8gUDoBbX6ZdjNOmxeFLigqWGygL1l2qr95YbNwYX1DX0AZl37J5S7yxSEwXVJcNZzx9G29Hf257GOimjELSi0wlKU0X+g6/ee2S3aR3a/H4mCIftU2MeeDk/41u1iJ5q2phvQgnfRq2F2UE8IZg1/hSq98CVzGqxZA+acjT4Gw6Lae6+/ehscVtIfkIa7Rqn3jqctHV+jFoCSX9AyZharFrlZzAICfy6jA3nqgvtTcazfDVbcgjFhDM7EococtJLpmEVJ7thjJdeLePT717SLp7PVjQ3QY4vb8Lz6mfAef/kndRw7kVUS7Hi+dQczwv4bnEXy7eEXxgaLW2fmOmzMUMBniFamH36C95MGat9JJQua3EtU9sNQDemwgzHWxIyIzbXtYPNKecBXH4JGE2FdCULc1XbZrqjLq4AbT3+UFYGjLag2BS5UqYA862p6oE69Wo1kJ6A5pgmLPRNXk1pzC5GYUTgy78XFqUuUCi1yhxoGrE20qwJFSiXlGdB1HGMB+zxa6yA+cRnlGHutslj+zGkHijdgqezotfZ17pg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(6486002)(66476007)(66946007)(31686004)(6512007)(316002)(6916009)(478600001)(53546011)(8936002)(6666004)(36916002)(4326008)(6506007)(8676002)(2616005)(7416002)(83380400001)(4744005)(2906002)(38100700002)(5660300002)(26005)(31696002)(36756003)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Qms0MURaM1Y4YkVtQjQvMkRRU3JqdE5weXkwNkRsYjJsSlZVM3dNY2dLL3Er?=
 =?utf-8?B?R2dqKzIycExJeG9ySUlYcUFUQ1F5bmZmRmFMVjNwaklyTisvY1pCREd2TS9l?=
 =?utf-8?B?dnU4ZnRMbVZJZWtySmY2SElaN084TlRaMWRabkVXR3NlNGl4a2lNanRueWxJ?=
 =?utf-8?B?R1Z1cFJFekpocTVlZmN3bURrczJtSjZ3b1Zoc25hVXA4VExmS2dId0FRNmsv?=
 =?utf-8?B?M1I3Vi9zM0VTNE5HdHI2YUgxWjc0WG9sUkkzdXlHRDR5alk5eGJrb1FWUVpB?=
 =?utf-8?B?eHo5aXhyTXh4Qyt3NG9JdjcxNGpuVjFYaVhPMk8yZHA2VVdlY1NNUTdMYnZ6?=
 =?utf-8?B?M2hBU2tuVGVQT29RNk9Oc0Q4MkdIZmxNT3JDSXJsOGVrL0JUMzVCR2Z6S201?=
 =?utf-8?B?aCtzYjVxOE02SzFzNmZvRnZhUUMzQ2tudFpVcmprRzBtY21TUEJvWTZPWUww?=
 =?utf-8?B?YnVRaGFGVURnYzYzVFhmVkpqenVuUGhRN202bzd0UnFXT2loQWl1cENhU1pQ?=
 =?utf-8?B?ZGV6YmhuTXNYWU10UlNyaXJ4YkNiZjhhYkhjaXB2WFdleUNYbEh0SlNYVi9W?=
 =?utf-8?B?bnFRUE15QkM3OE13QmxXbngvWk5iWloyNXM5MittOG9OZWZFZkVTaXFGYzNU?=
 =?utf-8?B?bjF3a3lob25hRTRhYjk5aGZsYzhNaGNSV3FFYi92YURPampQMWhRUFFRUm8x?=
 =?utf-8?B?SzFIQjlkNkx4WWd4ZUp5MWlrZlFTWkR2Tkxxb3JCbENBWXlydEIvaldxT3dq?=
 =?utf-8?B?RlMzcmpnY2NJRjdweFNlajAzWGp6Y2ZBckIwUngrcElJZDNNanRDejZHNkZs?=
 =?utf-8?B?RndPT0hZOU1UOW14VStsZkVjN0V6RVJQWVpYOVp5ZCtzZ3lvRjdXS0VvREVl?=
 =?utf-8?B?TXkweEJKM1FydjlVUGNCc3ZkM3BLRUNFcGMvMWl6SWJPZGhCWXd4NFY4NE9x?=
 =?utf-8?B?MzJoNXJ6d0VpK2c4MXg3RFh0eStKc1FaT0tMQ3NBZG9UdGdSemlxMnQ0NWhu?=
 =?utf-8?B?d1p0K3pBUk5nUG5KdWt0d0lSWG1lTGFoTWJYUzZIUVZ1Q1hwMHNtcGxiN3gx?=
 =?utf-8?B?NjU1YlpXMVNhRklsMFRPSnpsYjlwZFl3aWRKdEJxS1VJVjJMRDErN2JoRksz?=
 =?utf-8?B?L3lERjBneGo2eGFBd1hVKzN0clB2QkhTNkhKY2VocHBZN3lFZWo3NExiZlhF?=
 =?utf-8?B?Q3ZlOHRuR1pwQmU1LzJKUU5SQk04TXJ3MGVhR001ZVorajdrbUNqUkxwWllo?=
 =?utf-8?B?U1pUSWNodmhvazZOUnBDYUhpZk8rQnRRanIya0o5WDAwMGMxUGFVb1RCWk5J?=
 =?utf-8?B?ZUp0b0g0U0dFbGgvR296RWh6TmppeVFpd3RucUZaYVB0dlArVlhaeTFZTjVH?=
 =?utf-8?B?R2YxVE92ZGE4aEsxTzJIWWFWTEY2UGpZT2J2ZEVGNllqK2d2akt0bm1KdGJJ?=
 =?utf-8?B?MGRWNXVqZWVycFdlMjd4YmxCVUc3Sm5wSC9KbC9YeFZ5UE93RjVsWERxQmVk?=
 =?utf-8?B?VnRYcjdETkhwUVhkVE5xQnhBV3FzdmJHWThzMUs1YnJacURBQjNxLzE4TkxJ?=
 =?utf-8?B?cXZmRUZTdVIva2RoUlp0dmlnWWNQdzltdWh2clN4VTRlL2V2QzQwVXVQNnRm?=
 =?utf-8?B?QkhBenpIV0MyMDhqMXpqTVRFekNnbVlXODJOMC9aLzdqOEYyR3F6bncwTzVn?=
 =?utf-8?B?RnVzQzg5TGdwbXdWR3lKRENZZng5ZWxBbVZCN205WGFad0daM2JOQnluRE1y?=
 =?utf-8?B?QkN0RmUxWUE0RnlNZW0xMm9odFN2ajRNK2ZoMi80MXR1b0VpZFR1SmRVMmdu?=
 =?utf-8?B?WHpXNWZYL203YlBiMklaZk1PRWxKaWVmMmVTN1ZuQ2szSjBTVlR1M21hZURL?=
 =?utf-8?B?Ujdqb2VoQU1uOGliTkZpVHJJb3h2dWs0THgrT3NnOGY1TU9DKzJ1K1dURStG?=
 =?utf-8?B?Nk5iejZ6VEN0ZHREclUvSE5NaitmeGwyd1VoSHcveEFTQ0ZmOUtLTFhiRGVI?=
 =?utf-8?B?Q2JlUThlNWlGeFBRd0wzMTdLRGxUSVZSTEUrZCt4MXE0NXZGUi9tY3orUzJl?=
 =?utf-8?B?UE5JcEMyTFNPT1ViVEw2dXN5WVZ4RmFXMzhReDB4Z1lQL2dxWUIrTVpuOVEz?=
 =?utf-8?Q?Bd8qorrg40UbqRMY7960Z/PdH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gQLfRkIzRRaUvG69nPw6DwqBUgl3TXNKyWRjTIedJU7xFWyMWN5K/f9fsH6OBofTOq3Xq6xir268flZ8poNnDiL/0wLGT8TQjWRr8DIiRfUOhN6O+IrKsK56xmHGt2RxwWmjZ1M8UidWXyQEz1+zYBiwkkGT2FlLD4UPRvUMAOmBLEzKN41LFEigfQECIBdLy9UlEgLJdmxohxdBJ+xT5plcEjRT4ikd3PJs2zhZx4vCEuuUBKtVWcXByi/LKNevlzhhGp62MUJ0Ey/t9kHWv+O+W33bWRiWFA6xlB7s5Y6fOXrtrcY1N3LQY9tBMLmiLJHqBFKqDeCu41WXlkGfSvCyYSrrtXLQRJKz3XgUUBiKSvt6a8qa9Jh83i8mV8WTaMfE4RgQUlZIFBxJZQyJx9FpfTLEXilISAR2TZS/qLkiCW+z88aG0DdGVxMzmIFXfI5L1BI4/rXF7kOKiG9TuVgoESEGzbC9o68nrNX/kqMZWoH+tXqMMgGhdcq6uQPsS+0ZVyQLZaHrw0Y7dXwaKKe/HovFIErGz+B79pixSvsH6OY+b8cQCh50o9Uyb1BzKUn6cCiQW+cf0ZW9LS38gAwwrK2HdCY17U57Oje/UAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144eb20c-0985-436f-a84d-08dc22805425
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:16:14.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vNaTDkLinPrFJFm/Fm7HeRXvpGJkFmg8KzXED4y6OyC+HcFf8EAmSRtEP/fxPBQQx9p81E5F4UoU0UxUD6hrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310133
X-Proofpoint-GUID: rypZch8hlZq1XnOizqWVigFM5m8cYLpc
X-Proofpoint-ORIG-GUID: rypZch8hlZq1XnOizqWVigFM5m8cYLpc

On 31/01/2024 16:22, Greg KH wrote:
>> before:
>> real    0m53.591s
>> user    1m1.842s
>> sys     0m9.161s
>>
>> after:
>> real    0m37.481s
>> user    0m46.461s
>> sys     0m7.199s
>>
>> Sending as an RFC as I need to test more of the conversions and I would
>> like to also convert more UTS_RELEASE users to prove this is proper
>> approach.
> I like it, I also think that v4l2 includes this as well as all of those
> drivers seem to rebuild when this changes, does that not happen for you
> too?

I didn't see that. Were you were building for arm64? I can see some v4l2 
configs enabled there for the vanilla defconfig (but none for x86-64).

> 
> Anyway, if the firmware changes work, I'm all for this, thanks for
> taking it on!

cheers. BTW, I just noticed that utsrelase.h might not be updated for my 
allmodconfig build when I change the head commit - I'll investigate why ...

John

