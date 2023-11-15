Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74267EA4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKMU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:29:56 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236010CE;
        Mon, 13 Nov 2023 12:29:51 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77a277eb084so323164285a.2;
        Mon, 13 Nov 2023 12:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907391; x=1700512191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxwEsE0oS2KTnk/DXsji/2RtN10oLuZNrFbCTm6ZvU8=;
        b=C3cvtDeT3LuRYT7mxQCotvtF1G20OrsnvpQAZZlCCztnH0IFuP/IduH4XidmGu1BPk
         kzqq1OzUDsGezu8sMbIr0to7qBk09lhRtXszsNdWSG6zgf7qB854F9lwHTUhp0W99Gsy
         PliukUL7RTMYzrdHqujyTB/P1et9v+y4MXo2cMp+sl3GoT3jPLdY4gzaRzbG0cSzrw4g
         No89MD1La9mXU4whQgnlqx9Nvl8t/p7kZ5EltT6mRhTcRvldAgDAYZWreXRbYJKZJaDN
         RCE1eXlwC9IBzVQ63Y4/2eVGGMQr8X2pRp/25HIEsY0O8UkCywEsaGE4cxFKmmOdEUpA
         zRJw==
X-Gm-Message-State: AOJu0YzBL3GwLSc0vJ9+LmE1CecZp7v1mjdF7LRHswrXa4hqvNSkrObN
        rQ7oGGNVH8b9fuzIrIWcTUo=
X-Google-Smtp-Source: AGHT+IEjy74lURHdVFGE5jfjTx5MDPr29zE6efdBbXzEAiXKMsh90sPprQBqCBwN78H643Nv97wwag==
X-Received: by 2002:a05:620a:1310:b0:779:ecef:63fc with SMTP id o16-20020a05620a131000b00779ecef63fcmr323793qkj.6.1699907390910;
        Mon, 13 Nov 2023 12:29:50 -0800 (PST)
Received: from localhost ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a219c00b007788c1a81b6sm2119585qka.46.2023.11.13.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:29:50 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     corbet@lwn.net, netdev@vger.kernel.org, donald.hunter@gmail.com,
        kuba@kernel.org
Cc:     leit@meta.com, linux-doc@vger.kernel.org, pabeni@redhat.com,
        edumazet@google.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: Document each netlink family
Date:   Mon, 13 Nov 2023 12:29:36 -0800
Message-ID: <20231113202936.242308-1-leitao@debian.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple script that parses the Netlink YAML spec files
(Documentation/netlink/specs/), and generates RST files to be rendered
in the Network -> Netlink Specification documentation page.

Create a python script that is invoked during 'make htmldocs', reads the
YAML specs located under Documentation/netlink/specs, parses one by one
and generates a correspondent RST file for each YAML file.

Create a new Documentation/networking/netlink_spec index page, and
reference each Netlink RST file that was processed above in this main
index.rst file.

In case of any exception during the parsing, dump the error and skip
the file.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>

----
Changelog:

V2:
	* Moved the logic from a sphinx extension to a external script
	* Adjust some formatting as suggested by Donald Hunter and Jakub
	* Auto generating all the rsts instead of having stubs
	* Handling error gracefully
---
 Documentation/Makefile                        |   5 +-
 Documentation/networking/index.rst            |   1 +
 .../networking/netlink_spec/.gitignore        |   1 +
 .../networking/netlink_spec/readme.txt        |   4 +
 tools/net/ynl/ynl-gen-rst.py                  | 388 ++++++++++++++++++
 5 files changed, 398 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/netlink_spec/.gitignore
 create mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 tools/net/ynl/ynl-gen-rst.py

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2f35793acd2a..24a68fe1cd10 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -97,7 +97,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
-htmldocs:
+netlink_specs:
+	tools/net/ynl/ynl-gen-rst.py
+
+htmldocs: netlink_specs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 683eb42309cc..cb435c141794 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -55,6 +55,7 @@ Contents:
    filter
    generic-hdlc
    generic_netlink
+   netlink_spec/index
    gen_stats
    gtp
    ila
diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
new file mode 100644
index 000000000000..30d85567b592
--- /dev/null
+++ b/Documentation/networking/netlink_spec/.gitignore
@@ -0,0 +1 @@
+*.rst
diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
new file mode 100644
index 000000000000..6763f99d216c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/readme.txt
@@ -0,0 +1,4 @@
+SPDX-License-Identifier: GPL-2.0
+
+This file is populated during the build of the documentation (htmldocs) by the
+tools/net/ynl/ynl-gen-rst.py script.
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
new file mode 100755
index 000000000000..173bd25d9c4c
--- /dev/null
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -0,0 +1,388 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    Script to auto generate the documentation for Netlink specifications.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    This script performs extensive parsing to the Linux kernel's netlink YAML
+    spec files, in an effort to avoid needing to heavily mark up the original
+    YAML file.
+
+    This code is split in three big parts:
+        1) RST formatters: Use to convert a string to a RST output
+        2) Parser helpers: Functions to parse the YAML data structure
+        3) Main function and small helpers
+"""
+
+from typing import Any, Dict, List
+import os.path
+import sys
+import argparse
+import logging
+import yaml
+
+# Default location of the .yaml files
+SPEC_PATH = os.path.normpath(
+    os.path.join(__file__, "../../../../Documentation/netlink/specs")
+)
+# Default location of the output for the RST files
+OUTPUT_PATH = os.path.normpath(
+    os.path.join(__file__, "../../../../Documentation/networking/netlink_spec")
+)
+SPACE_PER_LEVEL = 4
+
+
+# RST Formatters
+# ==============
+def headroom(level: int) -> str:
+    """Return space to format"""
+    return " " * (level * SPACE_PER_LEVEL)
+
+
+def bold(text: str) -> str:
+    """Format bold text"""
+    return f"**{text}**"
+
+
+def inline(text: str) -> str:
+    """Format inline text"""
+    return f"``{text}``"
+
+
+def sanitize(text: str) -> str:
+    """Remove newlines and multiple spaces"""
+    # This is useful for some fields that are spread across multiple lines
+    return str(text).replace("\n", "").strip()
+
+
+def rst_fields(key: str, value: str, level: int = 0) -> str:
+    """Return a RST formatted field"""
+    return headroom(level) + f":{key}: {value}"
+
+
+def rst_definition(key: str, value: Any, level: int = 0) -> str:
+    """Format a single rst definition"""
+    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
+
+
+def rst_paragraph(paragraph: str, level: int = 0) -> str:
+    """Return a formatted paragraph"""
+    return headroom(level) + paragraph
+
+
+def rst_bullet(item: str, level: int = 0) -> str:
+    """Return a formatted a bullet"""
+    return headroom(level) + f" - {item}"
+
+
+def rst_subsection(title: str) -> str:
+    """Add a sub-section to the document"""
+    return f"{title}\n" + "-" * len(title)
+
+
+def rst_subsubsection(title: str) -> str:
+    """Add a sub-sub-section to the document"""
+    return f"{title}\n" + "~" * len(title)
+
+
+def rst_section(title: str) -> str:
+    """Add a section to the document"""
+    return f"\n{title}\n" + "=" * len(title)
+
+
+def rst_subtitle(title: str) -> str:
+    """Add a subtitle to the document"""
+    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
+
+
+def rst_title(title: str) -> str:
+    """Add a title to the document"""
+    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
+
+
+def rst_list_inline(list_: List[str], level: int = 0) -> str:
+    """Format a list using inlines"""
+    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
+
+
+def rst_header() -> str:
+    """The headers for all the auto generated RST files"""
+    lines = []
+
+    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
+    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
+
+    return "\n".join(lines)
+
+
+def rst_toctree(maxdepth: int = 2) -> str:
+    """Generate a toctree RST primitive"""
+    lines = []
+
+    lines.append(".. toctree::")
+    lines.append(f"   :maxdepth: {maxdepth}\n\n")
+
+    return "\n".join(lines)
+
+
+# Parsers
+# =======
+
+
+def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
+    """Parse 'multicast' group list and return a formatted string"""
+    lines = []
+    for group in mcast_group:
+        lines.append(rst_bullet(group["name"]))
+
+    return "\n".join(lines)
+
+
+def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'do' section and return a formatted string"""
+    lines = []
+    for key in do_dict.keys():
+        lines.append(rst_paragraph(bold(key), level + 1))
+        lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+
+    return "\n".join(lines)
+
+
+def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'attributes' section"""
+    if "attributes" not in attrs:
+        return ""
+    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
+
+    return "\n".join(lines)
+
+
+def parse_operations(operations: List[Dict[str, Any]]) -> str:
+    """Parse operations block"""
+    preprocessed = ["name", "doc", "title", "do", "dump"]
+    lines = []
+
+    for operation in operations:
+        lines.append(rst_section(operation["name"]))
+        lines.append(rst_paragraph(sanitize(operation["doc"])) + "\n")
+
+        for key in operation.keys():
+            if key in preprocessed:
+                # Skip the special fields
+                continue
+            lines.append(rst_fields(key, operation[key], 0))
+
+        if "do" in operation:
+            lines.append(rst_paragraph(":do:", 0))
+            lines.append(parse_do(operation["do"], 0))
+        if "dump" in operation:
+            lines.append(rst_paragraph(":dump:", 0))
+            lines.append(parse_do(operation["dump"], 0))
+
+        # New line after fields
+        lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
+    """Parse a list of entries"""
+    lines = []
+    for entry in entries:
+        if isinstance(entry, dict):
+            # entries could be a list or a dictionary
+            lines.append(
+                rst_fields(entry.get("name", ""), sanitize(entry.get("doc", "")), level)
+            )
+        elif isinstance(entry, list):
+            lines.append(rst_list_inline(entry, level))
+        else:
+            lines.append(rst_bullet(inline(sanitize(entry)), level))
+
+    lines.append("\n")
+    return "\n".join(lines)
+
+
+def parse_definitions(defs: Dict[str, Any]) -> str:
+    """Parse definitions section"""
+    preprocessed = ["name", "entries", "members"]
+    ignored = ["render-max"]  # This is not printed
+    lines = []
+
+    for definition in defs:
+        lines.append(rst_section(definition["name"]))
+        for k in definition.keys():
+            if k in preprocessed + ignored:
+                continue
+            lines.append(rst_fields(k, sanitize(definition[k]), 0))
+
+        # Field list needs to finish with a new line
+        lines.append("\n")
+        if "entries" in definition:
+            lines.append(rst_paragraph(":entries:", 0))
+            lines.append(parse_entries(definition["entries"], 1))
+        if "members" in definition:
+            lines.append(rst_paragraph(":members:", 0))
+            lines.append(parse_entries(definition["members"], 1))
+
+    return "\n".join(lines)
+
+
+def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
+    """Parse attribute from attribute-set"""
+    preprocessed = ["name", "type"]
+    ignored = ["checks"]
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(entry["name"]))
+        for attr in entry["attributes"]:
+            type_ = attr.get("type")
+            attr_line = bold(attr["name"])
+            if type_:
+                # Add the attribute type in the same line
+                attr_line += f" ({inline(type_)})"
+
+            lines.append(rst_subsubsection(attr_line))
+
+            for k in attr.keys():
+                if k in preprocessed + ignored:
+                    continue
+                lines.append(rst_fields(k, sanitize(attr[k]), 2))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_yaml(obj: Dict[str, Any]) -> str:
+    """Format the whole YAML into a RST string"""
+    lines = []
+
+    # Main header
+
+    lines.append(rst_header())
+
+    title = f"Family ``{obj['name']}`` netlink specification"
+    lines.append(rst_title(title))
+    lines.append(rst_paragraph(".. contents::\n"))
+
+    if "doc" in obj:
+        lines.append(rst_subtitle("Summary"))
+        lines.append(rst_paragraph(obj["doc"], 0))
+
+    # Operations
+    if "operations" in obj:
+        lines.append(rst_subtitle("Operations"))
+        lines.append(parse_operations(obj["operations"]["list"]))
+
+    # Multicast groups
+    if "mcast-groups" in obj:
+        lines.append(rst_subtitle("Multicast groups"))
+        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
+
+    # Definitions
+    if "definitions" in obj:
+        lines.append(rst_subtitle("Definitions"))
+        lines.append(parse_definitions(obj["definitions"]))
+
+    # Attributes set
+    if "attribute-sets" in obj:
+        lines.append(rst_subtitle("Attribute sets"))
+        lines.append(parse_attr_sets(obj["attribute-sets"]))
+
+    return "\n".join(lines)
+
+
+def parse_arguments() -> argparse.Namespace:
+    """Parse arguments from user"""
+    parser = argparse.ArgumentParser(description="Netlink RST generator")
+    parser.add_argument(
+        "-s", "--spec_dir", dest="spec_dir", type=str, default=SPEC_PATH
+    )
+    parser.add_argument(
+        "-o", "--output_dir", dest="output_dir", type=str, default=OUTPUT_PATH
+    )
+    parser.add_argument("-v", "--verbose", action="store_true")
+
+    args = parser.parse_args()
+
+    if args.verbose:
+        logging.basicConfig(level=logging.DEBUG)
+
+    for directory in [args.output_dir, args.spec_dir]:
+        if not os.path.isdir(directory):
+            logging.warning("%s is not a valid directory.", directory)
+            sys.exit(-1)
+
+    return args
+
+
+# Main functions
+# ==============
+
+
+def parse_yaml_file(filename: str) -> str:
+    """Transform the YAML specified by filename into a rst-formmated string"""
+    with open(filename, "r", encoding="utf-8") as spec_file:
+        yaml_data = yaml.safe_load(spec_file)
+        content = parse_yaml(yaml_data)
+
+    return content
+
+
+def write_to_rstfile(content: str, filename: str) -> None:
+    """Write the generated content into an RST file"""
+    logging.debug("Saving RST file to %s", filename)
+
+    with open(filename, "w", encoding="utf-8") as rst_file:
+        rst_file.write(content)
+
+
+def generate_main_index_rst(files: List[str], index_output: str) -> None:
+    """Generate the `networking_spec/index` content and write to the file"""
+    lines = []
+
+    lines.append(rst_header())
+    lines.append(rst_title("Netlink Specification"))
+    lines.append(rst_toctree(1))
+
+    for filename in files:
+        lines.append(f"   {filename}\n")
+
+    logging.debug("Writing an index file at %s for files: %s", index_output, files)
+    write_to_rstfile("".join(lines), index_output)
+
+
+def main() -> None:
+    """Main function that reads the YAML files and generates the RST files"""
+
+    args = parse_arguments()
+    processed_files = []
+
+    for yaml_file in os.listdir(args.spec_dir):
+        if not yaml_file.endswith(".yaml"):
+            continue
+
+        logging.debug("Parsing %s", yaml_file)
+        try:
+            content = parse_yaml_file(os.path.join(args.spec_dir, yaml_file))
+        except Exception as exception:
+            # Catch all exceptions and skip the file
+            logging.warning("Failed to parse %s.", yaml_file)
+            logging.warning(exception)
+            continue
+
+        output = os.path.join(args.output_dir, yaml_file.replace(".yaml", ".rst"))
+        write_to_rstfile(content, output)
+        processed_files.append(yaml_file.replace(".yaml", ""))
+
+    # Now generate the index for the index file referencing the auto generated files
+    generate_main_index_rst(processed_files, os.path.join(args.output_dir, "index.rst"))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.42.0

