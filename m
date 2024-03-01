Return-Path: <linux-kernel+bounces-89086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A405A86EA51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DF61C250B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DF3D548;
	Fri,  1 Mar 2024 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAW3YeYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="szG0IrXc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051227471;
	Fri,  1 Mar 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324858; cv=fail; b=kwopaXtxryPBeVNsyfwG8qqQgbN4o5OSda/xnI8J+C8VTOo5y004DfBSSGc9pSJUwYmzpYN5cUHuUkgxWriR0O0jSHjPNsvCqRjwsqgcQqZerTEna+/KueR18G0O2H/sP1BdLyg393KPOIqJBeUvTkEP30ZiOzK/5g3sutjlKxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324858; c=relaxed/simple;
	bh=OJyqwCeQ2UQt6t9whZ+pTCKE2cqkcCgXydP04VMzohI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QM4kDyoZdQVgpOdXJ+pjPT4Y6LFhj4CPGYWeUf3Z7oXyvMh6+7nG6a08wJ8IhQpRmorEyV8aqd7x2PJ41ZaJnsLvtDZjZOL9ktnIdiLmh9QIHj8i+FBBNK/+TBqmiA0YeCwqz/96wqvWKReprx2HXtb+z9L/6kovLqqU6miLVx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAW3YeYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=szG0IrXc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421GBiHN016054;
	Fri, 1 Mar 2024 20:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Dbnt4TfmcCaVgIx991NLF9AVAQiXhZT1A+AwFTDyXJM=;
 b=WAW3YeYcoiQHZ1GmYJslfg9ZmOkL2QMwNSudi2GwcN+tRZHhi/SF8iKq2GPl1sloPpzz
 sztbERSow/xYYbGKZ53zVIVC2Pk+2WzBGIeNqA2paNbd6XwXGIcY5L69P1yKRNOysaDa
 G/VgnGhagIcRsi3ycfpg8YIcdguDQx+AKHVzw8MZDUzhHF2q/56U+nr63M8kghve+T3N
 ILn5Px4q13RrpoSW3b7Vq/hlv3iqtY1TYDFEajrdRbtBT5C4kBxGe0d0nKqN02LRvfn2
 knoOrwGBQCJyJzXyM2VIxa2w+xsm5JAjABiZh5GBz64QjNGgL6Y2lJDy2PePO/rPxaRw tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbhjh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 20:27:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421J2OYE015313;
	Fri, 1 Mar 2024 20:27:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wcuvp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 20:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpicDEI4/ZZWRjF2Lj5w+TBOUgGXdhi+z1iXI18IOtliVF0Er05W/DOGjx9cN5cQpPX8bXdDbHr/IZoT2nGCHEPWxhp4ftilTBpruDs4wKx9Tu+AQdswiHx0yiSMBrTP5HNrYwNp1Q2bdko3TchGjkQrCASVNk5cb8jJ6phoF5ItkFd/oNg6zqpmgQjPz8uysWJyxWTFoHahyZjwkD+A2LcmXD8cRjQRydWpDGgm1kt3OR/f91s8x25DiyysnPS25lCh6l3JTiWv2RHrz3BmBKA8sGMAzzD2eShtTLRvu/1Hxjn+YqpMyVYFPUmKo4gJFAS/TyD0QjaROVpTw/ZXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbnt4TfmcCaVgIx991NLF9AVAQiXhZT1A+AwFTDyXJM=;
 b=cUL2lnhUHFqlJCik2VRqN2oMVEJP79rch7IatwNBCLRhA0Puh3E1zBi/ertzlaeGrCrmFGzoz/gKNByOyZeTfTK9LkVxqLn97Jx7IlzdYvQ3JnVHKh2RDrt1DC4VCeuG2ey3VjhYz4vVUfz68fEWyixWjgzSIYWpSfUc1h3eYaD8paPoCqfhkj83V3+8neYcQhD1NltL5I9J+YZdVqjOewJbT9CuS4R+HaLEWMCSUt93KgFwYGDdss7iZE8f0eTGWL89vWrGDOcboWDXTCdKaNaKhvySv56Z0VzsawM4xS6KqLnMOnDGYD/YQof3q+p2V44A0GYzIo/l9eDbKP53Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbnt4TfmcCaVgIx991NLF9AVAQiXhZT1A+AwFTDyXJM=;
 b=szG0IrXcXEGnXTAqb9NoPN+VrJ/a+JuZ0JxzCo9uGazsoXEzkFZFwifKJNlheSrNoH8wwW/QYdqfS71T5yFtAiC8GY3xGRosydue49BY3YZnHDaRj+AUSKzkA3iUOGMRoh+OCuupiG1J2tXaLDAnN3DcMbz0IRs6YLUFLb4xTW0=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 20:26:58 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c%5]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 20:26:58 +0000
Message-ID: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
Date: Fri, 1 Mar 2024 12:26:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, stable@vger.kernel.org,
        Dan Moulding <dan@danm.net>
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
 <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
From: junxiao.bi@oracle.com
In-Reply-To: <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 70284e88-e65a-4f36-5e48-08dc3a2df192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c++jq4vuSdOIsPRO1SoNdcZ801osDk9nPL4SMXzE7ahCHTtDD+L4ypzAWgwCNnqLSlp6MFqu8win1Y6qQi6zsNd8VmxR2S7eaD0g9vAoTIcUHWcjRoFiZUP96kx2G/2pC7o/57h0hdDiptguVDIjwU79uSKktLR5NTxZJgo4f8mtr04zfS5NPKTsLsoH9CnUZ28NRZL+V/N1U3Tij8WmfBDwXhsB/YdZA4hBSx5UziYjXPAO228gkVRU8xH9G6OJzWh8P8Rps+PgKPH+JPPZFd8Wy+m4RvLuwvWAblHtNOiJGQHJYj29jwUJGdZbKCiM6l98hgFt6fUcdUZjm2HozdyXYEa9/1Y9p2XyVWA3bA+qTVKATXwS3/yEeE54Yd2XNRk8XPp3uE6dAWQOEJgQPG3A9kuTpWqN/0Gl1Ny1ATTsMC10rVJ2nPyTH3zqOJU1hZpSVlpBqjh0xsuHx3Q11QJVdASM9wdYGzgs47cutXIz0lerO/bBxvPWIrB/NERKtKo7HMkVoTIGOdzyp8z5r8CJxDiJZjXrOt00dJctDjglwyBgMFeY5rNGpEYef1WDfbqRDloYvs1Jn8V7Z9zWmQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2drYlk0cTI2a0tnVnFPNmpod2tia1FFR2FSRVVha0NoT3BiWUIzbCtITlly?=
 =?utf-8?B?aVBYTW53bTZ4Tjd1YzM4WTU5M1VBOUpsQ1VxcE5vZ0VLYmgvaHZMVDNUaFRX?=
 =?utf-8?B?emZ0TG50L3haVmk3d0VXa1BoZnJIMWM4Zm9ONEFBbVVMamJOdzlUMk1OOEpX?=
 =?utf-8?B?YzVybjZuM1I4amJtaU1QSVl5SjAzTW53aGpyeXJDL3lPSnoxek1wU1lKbEJS?=
 =?utf-8?B?SHBpbWE0VTFldGxGdEpSaFdlQk1xeFI5K1l2Z2U1ZWVBOW5oZExZNVlZcW9L?=
 =?utf-8?B?T1puWjVKbFJXRHVld1VWWUp5SGxlNmxlanlWT2lVMGVKQ0dyUUxTOXhWVHhZ?=
 =?utf-8?B?eHBOaEhibGZiMmNzR1F0RGg0YUs1bGJGMU1UMGY2SXBvNWRDKzQzTGEzVVI3?=
 =?utf-8?B?Vkt5am5UTFFJcENhNWR4OWNQREZGbUJieVh4cVdkTTI2TGNFV2JNdS8xWU1U?=
 =?utf-8?B?dWhLQUFIeFpnRVJPV3RLalVKMWJMWTlTSWYzTVJibWlKaVJBdWZObWVUYm16?=
 =?utf-8?B?VVhqYkhqWWZlTDg3YWVQaDhlbzEyWXJaTERLdjN2YmxPeWlqQkc3Yzhsam52?=
 =?utf-8?B?bDRPTGJTRXByaTlmL3crMEV6WUJQd29WNGp1REkzVHBxUzNlQ1dWekd5bHBP?=
 =?utf-8?B?TFFMS29pVGdBVU5aTi85WWZZK0FwVFRsbUk0cnRIOTZadnZGNysyZDMwMDF0?=
 =?utf-8?B?cDBGS3NscGdpd095UFE1M2c4OTZ3d21HQmlRa2Jvd0tOckpITnV0Z1NZM3pk?=
 =?utf-8?B?VDBrNSs3Q0JYTW9hL3BnZjlZRlRRN0d3ZU91QUlONE01MEFzL3loOTBSZkVm?=
 =?utf-8?B?SUZPMFRqampLZDk5Z2pMOURmR3lna2w5dGJVNWR4NGt0TlBPYXNFOXpMM3Rq?=
 =?utf-8?B?Z1NwZi9kU1RPcnNyaHFhaG9mNDRkeGJqM1ZCS01VT1luVmhVQUYzbytkMTJG?=
 =?utf-8?B?UTZqZVhTREN3cTYwdmJtZmo4T3FFLytPQms4OTExZDhSdTE3VkNHUHVGMTJ1?=
 =?utf-8?B?Wkw4VmpGSnhCUWY0bmlSZC8vZjdmSzBvL3Ztck13Q284cTlRaGZudm9zajc4?=
 =?utf-8?B?YkNtcmViSHp4M1RUZ01DZVFjUGg5aXh4QVJPZ2Z4Qmk2a3dCNGJPOVdEVGQx?=
 =?utf-8?B?azBrNk5Od2NqM1h0SHExc2RXOUZ2LzFHbnFsMjhxMDJrL1ZLV1NPNmR4RWJN?=
 =?utf-8?B?VTFVUTQvaTg1czRXczZ6N2NDbEpSV1VpU2FFVlgyVktTeno3cTZCUlpzQklM?=
 =?utf-8?B?T05UNjZ0OXdXb2Z6ekx5L3UxakV4REwvZU1lREtweVk1Tm5VZUNWNVpsRHFS?=
 =?utf-8?B?bkpOZXV3MEhZdE1EbHc0S0FDeEExeldjaHJmcVZJc3pzYUxZUkJMVlBZek5L?=
 =?utf-8?B?WVVwNnZDT1d2V2U0U1VVbCtUYTNqamJKblNIT1FpOEJsbk5WTlZLQlBtWGJ0?=
 =?utf-8?B?K05URlNJQ0pKZVUwcTg5QmI1SmpjUFB2Unl2R1dQWXJrdEIyNFRSR2I0bnVW?=
 =?utf-8?B?akdmamw4eXhEdEl6VWRjVy9QaUtYTnR6Wk5iRFdSWlVOU3dnWTA0SzV2by92?=
 =?utf-8?B?TG5KY3QyM1NQM3M5V0ZMckhIYmxHdWZHQTBKbXdabmFpMHpBMHlEWU9sNHVH?=
 =?utf-8?B?cDNkV3JReHo0NzBWMnJaSDNhNWxDVE1XOU01WmwrZXIxUXV6bVcwRXkwMHRW?=
 =?utf-8?B?KzdKa0JqbFkzUkkwbVVLRGNUU3FsdUw5SVM4clhsakRNYWZVS2h5SFE5eWxH?=
 =?utf-8?B?ci82U2ZNa1hiRFoxdXdCQnZYSGRnRjhXZHpGYnE5VXNCWTE3SlByM1h3V0th?=
 =?utf-8?B?ajNZbWYzcEhwaVlwTXpTb2lTcVYxa0RDREp5VjF6Y0VRSUNMR3IvZVdLSnk0?=
 =?utf-8?B?RjZFeklxMkNYak1RS0xKSFpWY21GUmlDTHJmcThCSDM4K2tacWtFZzFZdSt6?=
 =?utf-8?B?TTZHNVVoTjhwWE9Vb0wvbWhVTUoxL05TU3RhSFcvQTBRMWNWZW1JWHNHWU1B?=
 =?utf-8?B?RnF6M1lxNENKOHJNdnl4OUVPRWIvY2MyTDVYL1pJM3NKRkV0dVFRdWVTM082?=
 =?utf-8?B?bGtobHlsQmZtV1ljak9xUjN1czJaYS9DaGNzRDlPNTd2b1U5NWtTZXorbklv?=
 =?utf-8?Q?uTPWF2p/LlelyRqZxAnVmamIS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZniL2Zcx7fv0DlEgdnD2Vsxt8wKNlCtYbxtW0H2xyT5MmSwfA4qpIKNUAp11D2LGBPjsmiEppgBCAQv6CBn+aLAXv8P6yXkpMsJwFifIlUTXzOjJ20xWuAmOgDderx9lR3A7eel0noO3xuFifi9g0Ri5B57q5RBNgQ+64NvaCigO5EDocJ9zyRjuanYJ4rESFXDIT4oWnIajhVXD3oU+Yu/85Bj4MXcxA9KsBZ2K2aN1iJmDdvf4Khqax7AsrKNTSg150iofQL7qzK0JqyRyryDJoo3POy2DV4XpEWnxobao71Ltwdof9/pUXtaJ9L1AaUPScOZDMd+GXj0f25L8QefdV6g3KOXaR823yoP4GjkW4FtC/nZ3yBQ2JgsxF6A/KYPlN5xiOezU+iduNHTTLKCq/DlsgCQaxQCEOUeAWwlhwqvBNJgtii4M4gHw8hPFAdAUQpYSUCBurcvrorSLEHBKbz/G6+S0yqHt5Vwh0ZW9DStqnhUs8kGODOW9nap6fm4haeD5o43HdjehGypQl/2MsNKJ14LhIXeAtoaPgL+DrBRodqA23X6PJAGeNl0qpq8EKfHfoINHWCKlv8WzYoFnhsjzScecSikozG0+Y1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70284e88-e65a-4f36-5e48-08dc3a2df192
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:26:58.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juR9sUzA9jvUGye/kFt+r+LXo8p41KJ/lrcNwvts0ISZG+4A2E7xJm7/Ub87maKOfbVrlpkMKJs98W5zQOFHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010169
X-Proofpoint-GUID: -zvAPw0UkWAh4w_1D_QsHNHDmqHCKnuw
X-Proofpoint-ORIG-GUID: -zvAPw0UkWAh4w_1D_QsHNHDmqHCKnuw

Hi Dan & Song,

I have not root cause this yet, but would like share some findings from 
the vmcore Dan shared. From what i can see, this doesn't look like a md 
issue, but something wrong with block layer or below.

1. There were multiple process hung by IO over 15mins.

crash> ps -m | grep UN
[0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0  CPU: 1    
COMMAND: "jbd2/dm-3-8"
[0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0  CPU: 2    
COMMAND: "dd"
[0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3    
COMMAND: "md0_reclaim"
[0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740  CPU: 1    
COMMAND: "kworker/1:2"
[0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80  CPU: 7    
COMMAND: "kworker/u21:1"

2. Let pick md0_reclaim to take a look, it is waiting done super_block 
update. We can see there were two pending superblock write and other 
pending io for the underling physical disk, which caused these process hung.

crash> bt 876
PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
  #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
  #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
  #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
  #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
  #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
  #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
  #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
  #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
  #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1

crash> mddev.pending_writes,disks 0xffff888108335800
   pending_writes = {
     counter = 2  <<<<<<<<<< 2 active super block write
   },
   disks = {
     next = 0xffff88810ce85a00,
     prev = 0xffff88810ce84c00
   },
crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
0xffff88810ce85a00
ffff88810ce85a00
   kobj.name = 0xffff8881067c1a00 "dev-dm-1",
   nr_pending = {
     counter = 0
   },
ffff8881083ace00
   kobj.name = 0xffff888100a93280 "dev-sde",
   nr_pending = {
     counter = 10 <<<<
   },
ffff8881010ad200
   kobj.name = 0xffff8881012721c8 "dev-sdc",
   nr_pending = {
     counter = 8 <<<<<
   },
ffff88810ce84c00
   kobj.name = 0xffff888100325f08 "dev-sdd",
   nr_pending = {
     counter = 2 <<<<<
   },

3. From block layer, i can find the inflight IO for md superblock write 
which has been pending 955s which matches with the hung time of 
"md0_reclaim"

crash> 
request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
ffff888103b4c300
   q = 0xffff888103a00d80,
   mq_hctx = 0xffff888103c5d200,
   cmd_flags = 38913,
   rq_flags = 139408,
   start_time_ns = 1504179024146,
   bio = 0x0,
   biotail = 0xffff888120758e40,
   state = MQ_RQ_COMPLETE,
   __data_len = 0,
   flush = {
     seq = 3, <<<< REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA
     saved_end_io = 0x0
   },
   end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,

crash> p tk_core.timekeeper.tkr_mono.base
$1 = 2459916243002
crash> eval 2459916243002-1504179024146
hexadecimal: de86609f28
     decimal: 955737218856  <<<<<<< IO pending time is 955s
       octal: 15720630117450
      binary: 
0000000000000000000000001101111010000110011000001001111100101000

crash> bio.bi_iter,bi_end_io 0xffff888120758e40
   bi_iter = {
     bi_sector = 8, <<<< super block offset
     bi_size = 0,
     bi_idx = 0,
     bi_bvec_done = 0
   },
   bi_end_io = 0xffffffff817dca50 <super_written>,
crash> dev -d | grep ffff888103a00d80
     8 ffff8881003ab000   sdd        ffff888103a00d80       0 0     0

4. Check above request, even its state is "MQ_RQ_COMPLETE", but it is 
still pending. That's because each md superblock write was marked with 
REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 steps: pre_flush, 
data, and post_flush. Once each step complete, it will be marked in 
"request.flush.seq", here the value is 3, which is REQ_FSEQ_PREFLUSH |  
REQ_FSEQ_DATA, so the last step "post_flush" has not be done.  Another 
wired thing is that blk_flush_queue.flush_data_in_flight is still 1 even 
"data" step already done.

crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
   fq = 0xffff88810332e240,
crash> blk_flush_queue 0xffff88810332e240
struct blk_flush_queue {
   mq_flush_lock = {
     {
       rlock = {
         raw_lock = {
           {
             val = {
               counter = 0
             },
             {
               locked = 0 '\000',
               pending = 0 '\000'
             },
             {
               locked_pending = 0,
               tail = 0
             }
           }
         }
       }
     }
   },
   flush_pending_idx = 1,
   flush_running_idx = 1,
   rq_status = 0 '\000',
   flush_pending_since = 4296171408,
   flush_queue = {{
       next = 0xffff88810332e250,
       prev = 0xffff88810332e250
     }, {
       next = 0xffff888103b4c348, <<<< the request is in this list
       prev = 0xffff888103b4c348
     }},
   flush_data_in_flight = 1,  >>>>>> still 1
   flush_rq = 0xffff888103c2e000
}

crash> list 0xffff888103b4c348
ffff888103b4c348
ffff88810332e260

crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of hw queue
   tag = -1,
   state = MQ_RQ_IDLE,
   ref = {
     counter = 0
   },

5. Looks like the block layer or underlying(scsi/virtio-scsi) may have 
some issue which leading to the io request from md layer stayed in a 
partial complete statue. I can't see how this can be related with the 
commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
raid5d"")


Dan,

Are you able to reproduce using some regular scsi disk, would like to 
rule out whether this is related with virtio-scsi?

And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
official mainline v6.8-rc5 without any other patches?


Thanks,

Junxiao.

On 2/23/24 6:13 PM, Song Liu wrote:
> Hi,
>
> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 21.02.24 00:06, Dan Moulding wrote:
>>> Just a friendly reminder that this regression still exists on the
>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>> development system to 6.8-rc5 today and immediately hit this issue
>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>> Song Liu, what's the status here? I aware that you fixed with quite a
>> few regressions recently, but it seems like resolving this one is
>> stalled. Or were you able to reproduce the issue or make some progress
>> and I just missed it?
> Sorry for the delay with this issue. I have been occupied with some
> other stuff this week.
>
> I haven't got luck to reproduce this issue. I will spend more time looking
> into it next week.
>
>> And if not, what's the way forward here wrt to the release of 6.8?
>> Revert the culprit and try again later? Or is that not an option for one
>> reason or another?
> If we don't make progress with it in the next week, we will do the revert,
> same as we did with stable kernels.
>
>> Or do we assume that this is not a real issue? That it's caused by some
>> oddity (bit-flip in the metadata or something like that?) only to be
>> found in Dan's setup?
> I don't think this is because of oddities. Hopefully we can get more
> information about this soon.
>
> Thanks,
> Song
>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>

